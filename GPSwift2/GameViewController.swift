//
//  GameViewController.swift
//  GPSwift2
//
//  Created by Vladimir Vinnik on 25.12.15.
//  Copyright (c) 2015 Vladimir Vinnik. All rights reserved.
//

import UIKit
import SpriteKit
import iAd
import GameKit
import GoogleMobileAds

var iADBanner: ADBannerView!

class GameViewController: UIViewController, ADBannerViewDelegate, GKGameCenterControllerDelegate, ChartboostDelegate, GADBannerViewDelegate, GADInterstitialDelegate {
    
    @IBOutlet var adMobBannerView: GADBannerView!
    @IBOutlet var adMobInterstital: GADInterstitial!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let scene = MenuScene(fileNamed:"MenuScene") {
            //Check first launch
            if !(NSUserDefaults.standardUserDefaults().boolForKey("HasLaunchedOnce")) {
                //First launch
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "HasLaunchedOnce")
                
                //Set stats
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "ShowTutorial");
                
                NSUserDefaults.standardUserDefaults().setInteger(1, forKey: "CurrentSkin")
                NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "Coins")
                
                NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "CurrentScore")
                NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "BestScore")
                
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: "Skin2IsUnlock")
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: "Skin3IsUnlock")
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: "Skin4IsUnlock")
            }
            
            //Configure the view
            let skView = self.view as! SKView
            skView.showsFPS = false
            skView.showsNodeCount = false
            skView.ignoresSiblingOrder = true
            scene.scaleMode = .AspectFill
            scene.size = skView.frame.size
            
            //Get stats
            NSUserDefaults.standardUserDefaults().setFloat(Float(skView.frame.size.width), forKey: "SizeWidth")
            NSUserDefaults.standardUserDefaults().setFloat(Float(skView.frame.size.height), forKey: "SizeHeight")
            
            //Load other feature
            loadAds()
            authenticateLocalPlayer()
            
            //Get links
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GameViewController.iAdShow), name: "iAdShow", object: nil)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GameViewController.iAdHide), name: "iAdHide", object: nil)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GameViewController.showChartboostVideo), name: "showChartboostVideo", object: nil)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GameViewController.adMobShow), name: "adMobShow", object: nil)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GameViewController.adMobHide), name: "adMobHide", object: nil)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GameViewController.adMobInterstitialCall), name: "adMobInterstitialCall", object: nil)
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GameViewController.rateUs), name: "rateUs", object: nil)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GameViewController.showLeaderboard), name: "showLeaderboard", object: nil)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GameViewController.submitScore), name: "submitScore", object: nil)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GameViewController.share), name: "share", object: nil)

            skView.presentScene(scene)
        }
    }
    
    //MARK: ADs
    
    func loadAds() {
        //iAD
        iADBanner = ADBannerView(frame: CGRectZero)
        iADBanner.delegate = self
        iADBanner.frame = CGRectOffset(iADBanner.frame, 0, 0.0);
        var adFrame = iADBanner.frame
        adFrame.origin.y = self.view.frame.size.height - iADBanner.frame.size.height
        iADBanner.frame = adFrame
        view.addSubview(iADBanner)
        
        //Chartboost
        //See chartboost initialisation in GPSwift2->Default->AppDelegate.swift
        
        //Google AdMob
        adMobBannerView = GADBannerView(adSize: kGADAdSizeBanner)
        adMobBannerView?.adUnitID = GlobalSettings.adMobBannerUnitID
        adMobBannerView?.delegate = self
        adMobBannerView?.rootViewController = self
        adMobBannerView?.frame.origin = CGPointMake(0, CGFloat(NSUserDefaults.standardUserDefaults().floatForKey("SizeHeight")) - adMobBannerView.frame.size.height)
        
        //Google AdMob Interstitial
        adMobInterstital = GADInterstitial.init(adUnitID: GlobalSettings.adMobBannerUnitID)
        adMobInterstital?.delegate = self
        
        let request = GADRequest()
        request.testDevices = [GlobalSettings.adMobTestDeviceID]
        
        view.addSubview(adMobBannerView!)
        adMobBannerView?.loadRequest(request)
        adMobInterstital?.loadRequest(request)
    }
    
    func iAdShow() { iADBanner.alpha = 1}
    func iAdHide() { iADBanner.alpha = 0}
    
    func showChartboostVideo() { Chartboost.showInterstitial(CBLocationDefault)}
    
    func adMobShow() { adMobBannerView.alpha = 1}
    func adMobHide() { adMobBannerView.alpha = 0}
    
    func adMobInterstitialCall() {adMobInterstital?.presentFromRootViewController(self)}
    
    //MARK: RateUS
    
    func rateUs() {
        let alert = UIAlertController(title: "Like this game?", message: "Rate us in app store", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
            //Go to link
            UIApplication.sharedApplication().openURL(NSURL(string: GlobalSettings.linkToRateUs)!)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    //MARK: GameCenter
    
    func authenticateLocalPlayer() {
        let localPlayer: GKLocalPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {(ViewController, error) -> Void in
            //1 Show login if player is not logged in
            if ViewController != nil {
                self.presentViewController(ViewController!, animated: true, completion: nil)
            }
            //2 Player is already euthenticated & logged in, load game center
            else if localPlayer.authenticated {
                // Get the default leaderboard ID
                localPlayer.loadDefaultLeaderboardIdentifierWithCompletionHandler({ (leaderboardIdentifer: String?, error: NSError?) -> Void in if error != nil { print(error) }})
            }
            //3 Game center is not enabled on the users device
            else { print("Local player could not be authenticated, disabling game center")}
            
            if error != nil { print(error)}
        }
    }
    
    func submitScore() {
        let sScore = GKScore(leaderboardIdentifier: GlobalSettings.leaderboardId)
        sScore.value = Int64(NSUserDefaults.standardUserDefaults().integerForKey("BestScore"))
        
        GKScore.reportScores([sScore], withCompletionHandler: { (error: NSError?) -> Void in
            if error != nil { print(error!.localizedDescription)}
            else { print("Score submitted")}
        })
    }
    
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func showLeaderboard() {
        let gcVC: GKGameCenterViewController = GKGameCenterViewController()
        gcVC.gameCenterDelegate = self
        gcVC.viewState = GKGameCenterViewControllerState.Leaderboards
        gcVC.leaderboardIdentifier = GlobalSettings.leaderboardId
        self.presentViewController(gcVC, animated: true, completion: nil)
    }
    
    //MARK: Share
    
    func share() {
        let text: String  = GlobalSettings.shareText
        let dataImage: NSData = NSUserDefaults.standardUserDefaults().objectForKey("CurrentScreenShot") as! NSData
        let image: UIImage = UIImage(data: dataImage)!
        let shareItems: Array = [image, text]
        
        let activityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view;
        activityViewController.excludedActivityTypes = [UIActivityTypePrint, UIActivityTypePostToWeibo, UIActivityTypeCopyToPasteboard, UIActivityTypeAddToReadingList, UIActivityTypePostToVimeo]
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    //MARK: Other

    override func shouldAutorotate() -> Bool { return true}

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone { return .AllButUpsideDown}
        else { return .All}
    }

    override func prefersStatusBarHidden() -> Bool { return true}
}
