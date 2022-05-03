//
//  EndScene.swift
//  GPSwift2
//
//  Created by Vladimir Vinnik on 02.01.16.
//  Copyright © 2016 Vladimir Vinnik. All rights reserved.
//

import SpriteKit

class EndScene: GlobalScene {
    
    @IBOutlet var background: SimpleNode?
    @IBOutlet var logo: SimpleNode?
    @IBOutlet var bestScoreIndicator: SimpleNode?
    
    @IBOutlet var buttonRestart: ButtonNode?
    @IBOutlet var buttonMenu: ButtonNode?
    @IBOutlet var buttonShare: ButtonNode?
    @IBOutlet var buttonGameCenter: ButtonNode?
    
    @IBOutlet var labelCurrentScore: SimpleLabel?
    @IBOutlet var labelCurrentScoreName: SimpleLabel?
    @IBOutlet var labelBestScore: SimpleLabel?
    @IBOutlet var labelBestScoreName: SimpleLabel?
    
    override func didMoveToView(view: SKView) {
        initComponents()
        if GlobalSettings.iAdShow.endScene { NSNotificationCenter.defaultCenter().postNotificationName("iAdShow", object: nil)}
        else { NSNotificationCenter.defaultCenter().postNotificationName("iAdHide", object: nil)}
        
        if GlobalSettings.chartboostShow.endScene { Chartboost.showInterstitial(CBLocationDefault)}
        
        if GlobalSettings.adMobShow.endScene { NSNotificationCenter.defaultCenter().postNotificationName("adMobShow", object: nil)}
        else { NSNotificationCenter.defaultCenter().postNotificationName("adMobHide", object: nil)}
        
        if GlobalSettings.adMobInterstitialCall.endScene { NSNotificationCenter.defaultCenter().postNotificationName("adMobInterstitialCall", object: nil)}
        
        setInteface()
    }
    
    //MARK: Set nodes
    
    func setInteface() {
        background = SimpleNode(imageName: EndSceneSettings.imageName.background, size: EndSceneSettings.size.background, position: EndSceneSettings.position.background, zPosition: EndSceneSettings.zPosition.background)
        logo = SimpleNode(imageName: EndSceneSettings.imageName.logo, size: EndSceneSettings.size.logo, position: EndSceneSettings.position.logo, zPosition: EndSceneSettings.zPosition.logo)
        
        buttonRestart = ButtonNode(imageSimpleName: EndSceneSettings.imageName.buttonRestartSimple, imagePressedName: EndSceneSettings.imageName.buttonRestartPressed, size: EndSceneSettings.size.buttonRestart, position: EndSceneSettings.position.buttonRestart, zPosition: EndSceneSettings.zPosition.buttonRestart)
        buttonMenu = ButtonNode(imageSimpleName: EndSceneSettings.imageName.buttonMenuSimple, imagePressedName: EndSceneSettings.imageName.buttonMenuPressed, size: EndSceneSettings.size.buttonMenu, position: EndSceneSettings.position.buttonMenu, zPosition: EndSceneSettings.zPosition.buttonMenu)
        buttonShare = ButtonNode(imageSimpleName: EndSceneSettings.imageName.buttonShareSimple, imagePressedName: EndSceneSettings.imageName.buttonSharePressed, size: EndSceneSettings.size.buttonShare, position: EndSceneSettings.position.buttonShare, zPosition: EndSceneSettings.zPosition.buttonShare)
        buttonGameCenter = ButtonNode(imageSimpleName: EndSceneSettings.imageName.buttonGameCenterSimple, imagePressedName: EndSceneSettings.imageName.buttonGameCenterPressed, size: EndSceneSettings.size.buttonGameCenter, position: EndSceneSettings.position.buttonGameCenter, zPosition: EndSceneSettings.zPosition.buttonGameCenter)
        
        labelCurrentScore = SimpleLabel(text: String(NSUserDefaults.standardUserDefaults().integerForKey("CurrentScore")), fontSize: EndSceneSettings.fontSize.labelCurrentScore, fontColorHex: EndSceneSettings.fontColor.labelCurrentScore, position: EndSceneSettings.position.labelCurrentScore, zPosition: EndSceneSettings.zPosition.labelCurrentScore)
        labelCurrentScoreName = SimpleLabel(text: EndSceneSettings.labelText.labelCurrentScoreName, fontSize: EndSceneSettings.fontSize.labelBestScoreName, fontColorHex: EndSceneSettings.fontColor.labelCurrentScoreName, position: EndSceneSettings.position.labelCurrentScoreName, zPosition: EndSceneSettings.zPosition.labelCurrentScoreName)
        labelBestScore = SimpleLabel(text: String(NSUserDefaults.standardUserDefaults().integerForKey("BestScore")), fontSize: EndSceneSettings.fontSize.labelBestScore, fontColorHex: EndSceneSettings.fontColor.labelBestScore, position: EndSceneSettings.position.labelBestScore, zPosition: EndSceneSettings.zPosition.labelBestScore)
        labelBestScoreName = SimpleLabel(text: EndSceneSettings.labelText.labelBestScoreName, fontSize: EndSceneSettings.fontSize.labelBestScoreName, fontColorHex: EndSceneSettings.fontColor.labelBestScoreName, position: EndSceneSettings.position.labelBestScoreName, zPosition: EndSceneSettings.zPosition.labelBestScoreName)
        
        if NSUserDefaults.standardUserDefaults().boolForKey("NewBestScore") {
            bestScoreIndicator = SimpleNode(imageName: EndSceneSettings.imageName.bestScoreIndicator, size: EndSceneSettings.size.bestScoreIndicator, position: EndSceneSettings.position.bestScoreIndicator, zPosition: EndSceneSettings.zPosition.bestScoreIndicator)
            self.addChild(bestScoreIndicator!)
        }
        
        self.addChild(background!)
        self.addChild(logo!)
        
        self.addChild(buttonRestart!)
        self.addChild(buttonMenu!)
        self.addChild(buttonShare!)
        self.addChild(buttonGameCenter!)
        
        self.addChild(labelCurrentScore!)
        self.addChild(labelCurrentScoreName!)
        self.addChild(labelBestScore!)
        self.addChild(labelBestScoreName!)
    }
    
    //MARK: Input
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        buttonRestart?.changeButtonStateToSimpleState(true)
        buttonMenu?.changeButtonStateToSimpleState(true)
        buttonShare?.changeButtonStateToSimpleState(true)
        buttonGameCenter?.changeButtonStateToSimpleState(true)
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            if buttonRestart!.containsPoint(location) {
                sounds.playSoundByName("buttonClick")
                changeSceneToSceneName("GameScene", withAnimationName: "MoveUp")
            }
            if buttonMenu!.containsPoint(location) {
                sounds.playSoundByName("buttonClick")
                changeSceneToSceneName("MenuScene", withAnimationName: "MoveUp")
            }
            if buttonShare!.containsPoint(location) {
                sounds.playSoundByName("buttonClick")
                NSNotificationCenter.defaultCenter().postNotificationName("share", object: nil)
            }
            if buttonGameCenter!.containsPoint(location) {
                sounds.playSoundByName("buttonClick")
                NSNotificationCenter.defaultCenter().postNotificationName("showLeaderboard", object: nil)
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            
            if buttonRestart!.containsPoint(location) {
                buttonRestart?.changeButtonStateToSimpleState(false)
                sounds.playSoundByName("buttonClickStart")
            }
            if buttonMenu!.containsPoint(location) {
                buttonMenu?.changeButtonStateToSimpleState(false)
                sounds.playSoundByName("buttonClickStart")
            }
            if buttonShare!.containsPoint(location) {
                buttonShare?.changeButtonStateToSimpleState(false)
                sounds.playSoundByName("buttonClickStart")
            }
            if buttonGameCenter!.containsPoint(location) {
                buttonGameCenter?.changeButtonStateToSimpleState(false)
                sounds.playSoundByName("buttonClickStart")
            }
        }
    }
    
}
