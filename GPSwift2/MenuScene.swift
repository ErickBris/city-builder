//
//  MenuScene.swift
//  GPSwift2
//
//  Created by Vladimir Vinnik on 02.01.16.
//  Copyright © 2016 Vladimir Vinnik. All rights reserved.
//

import SpriteKit

class MenuScene: GlobalScene {
    
    @IBOutlet var background: SimpleNode?
    @IBOutlet var logo: SimpleNode?
    
    @IBOutlet var buttonStart: ButtonNode?
    @IBOutlet var buttonRateUs: ButtonNode?
    @IBOutlet var buttonGameCenter: ButtonNode?
    
    @IBOutlet var labelBestScore: SimpleLabel?
    
    override func didMoveToView(view: SKView) {
        initComponents()
        if GlobalSettings.iAdShow.menuScene { NSNotificationCenter.defaultCenter().postNotificationName("iAdShow", object: nil)}
        else { NSNotificationCenter.defaultCenter().postNotificationName("iAdHide", object: nil)}
        
        if GlobalSettings.chartboostShow.menuScene { Chartboost.showInterstitial(CBLocationDefault)}
        
        if GlobalSettings.adMobShow.menuScene { NSNotificationCenter.defaultCenter().postNotificationName("adMobShow", object: nil)}
        else { NSNotificationCenter.defaultCenter().postNotificationName("adMobHide", object: nil)}
        
        if GlobalSettings.adMobInterstitialCall.menuScene { NSNotificationCenter.defaultCenter().postNotificationName("adMobInterstitialCall", object: nil)}
        
        setInteface()
    }
    
    //MARK: Set nodes
    
    func setInteface() {
        background = SimpleNode(imageName: MenuSceneSettings.imageName.background, size: MenuSceneSettings.size.background, position: MenuSceneSettings.position.background, zPosition: MenuSceneSettings.zPosition.background)
        logo = SimpleNode(imageName: MenuSceneSettings.imageName.logo, size: MenuSceneSettings.size.logo, position: MenuSceneSettings.position.logo, zPosition: MenuSceneSettings.zPosition.logo)
        
        buttonStart = ButtonNode(imageSimpleName: MenuSceneSettings.imageName.buttonStartSimple, imagePressedName: MenuSceneSettings.imageName.buttonStartPressed, size: MenuSceneSettings.size.buttonStart, position: MenuSceneSettings.position.buttonStart, zPosition: MenuSceneSettings.zPosition.buttonStart)
        buttonRateUs = ButtonNode(imageSimpleName: MenuSceneSettings.imageName.buttonRateUsSimple, imagePressedName: MenuSceneSettings.imageName.buttonRateUsPressed, size: MenuSceneSettings.size.buttonRateUs, position: MenuSceneSettings.position.buttonRateUs, zPosition: MenuSceneSettings.zPosition.buttonRateUs)
        buttonGameCenter = ButtonNode(imageSimpleName: MenuSceneSettings.imageName.buttonGameCenterSimple, imagePressedName: MenuSceneSettings.imageName.buttonGameCenterPressed, size: MenuSceneSettings.size.buttonGameCenter, position: MenuSceneSettings.position.buttonGameCenter, zPosition: MenuSceneSettings.zPosition.buttonGameCenter)
        
        labelBestScore = SimpleLabel(text: MenuSceneSettings.labelText.labelBestScore + String(NSUserDefaults.standardUserDefaults().integerForKey("BestScore")), fontSize: MenuSceneSettings.fontSize.labelBestScore, fontColorHex: MenuSceneSettings.fontColor.labelBestScore, position: MenuSceneSettings.position.labelBestScore, zPosition: MenuSceneSettings.zPosition.labelBestScore)

        self.addChild(background!)
        self.addChild(logo!)
        
        self.addChild(buttonStart!)
        self.addChild(buttonRateUs!)
        self.addChild(buttonGameCenter!)
        
        self.addChild(labelBestScore!)
    }
    
    //MARK: Input
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        buttonStart?.changeButtonStateToSimpleState(true)
        buttonRateUs?.changeButtonStateToSimpleState(true)
        buttonGameCenter?.changeButtonStateToSimpleState(true)
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            if buttonStart!.containsPoint(location) {
                sounds.playSoundByName("buttonClick")
                changeSceneToSceneName("GameScene", withAnimationName: "MoveDown")
            }
            if buttonRateUs!.containsPoint(location) {
                sounds.playSoundByName("buttonClick")
                NSNotificationCenter.defaultCenter().postNotificationName("rateUs", object: nil)
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
            
            if buttonStart!.containsPoint(location) {
                buttonStart?.changeButtonStateToSimpleState(false)
                sounds.playSoundByName("buttonClickStart")
            }
            if buttonRateUs!.containsPoint(location) {
                buttonRateUs?.changeButtonStateToSimpleState(false)
                sounds.playSoundByName("buttonClickStart")
            }
            if buttonGameCenter!.containsPoint(location) {
                buttonGameCenter?.changeButtonStateToSimpleState(false)
                sounds.playSoundByName("buttonClickStart")
            }
        }
    }
}
