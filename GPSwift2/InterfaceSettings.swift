//
//  InterfaceSettings.swift
//  GPSwift2
//
//  Created by Vladimir Vinnik on 02.01.16.
//  Copyright © 2016 Vladimir Vinnik. All rights reserved.
//

import Foundation
import SpriteKit

struct GameSceneSettings {
    struct imageName {
        static let bgBack = "bgBack"
        static let bgMiddle = "bgMiddle"
        static let bgFront = "bgFront"
        static let tutorial = "tutorial_GameScene"
        
        static let block1 = "block1"
        static let block2 = "block2"
        static let block3 = "block3"
        static let block4 = "block4"
        static let block5 = "block5"
    }
    
    struct size {
        static let bgBack = CGSize.CGSizeWithPercent(100, height: 100)
        static let bgMiddle = CGSize.CGSizeWithPercent(100, height: 100)
        static let bgFront = CGSize.CGSizeWithPercent(100, height: 100)
        static let tutorial = CGSize.CGSizeWithPercent(100, height: 100)
        
        static let block = CGSize.CGSizeWithPercentScaled(11, height: 11)
    }
    
    struct fontSize {
        static let labelScore: CGFloat = 145
    }
    
    struct fontColor {
        static let labelScore = "#659492"
    }
    
    struct position {
        static let bgBack = CGPoint.CGPointWithPercent(50, height: 50)
        static let bgMiddle = CGPoint.CGPointWithPercent(50, height: 50)
        static let bgFront = CGPoint.CGPointWithPercent(50, height: 50)
        static let tutorial = CGPoint.CGPointWithPercent(50, height: 50)
        
        static let labelScore = CGPoint.CGPointWithPercent(50, height: 65)
        
        static let line1Width = CGFloat(GlobalSettings.sizeWidth / 100 * 28)
        static let line2Width = CGFloat(GlobalSettings.sizeWidth / 100 * 39)
        static let line3Width = CGFloat(GlobalSettings.sizeWidth / 100 * 50)
        static let line4Width = CGFloat(GlobalSettings.sizeWidth / 100 * 61)
        static let line5Width = CGFloat(GlobalSettings.sizeWidth / 100 * 72)
        
        static let lineBorder = CGFloat(GlobalSettings.sizeHeight / 100 * 17)
        
        static let blockStartPositionHeight = CGFloat(GlobalSettings.sizeHeight / 100 * 120)
        
        static let block = CGPoint.CGPointWithPercent(50, height:120)
    }
    
    struct zPosition {
        static let bgBack: CGFloat = -100
        static let bgMiddle: CGFloat = -90
        static let bgFront: CGFloat = -80
        static let tutorial: CGFloat = 1000
        
        static let labelScore: CGFloat = 0.1
        
        static let block: CGFloat = 5
    }
}

struct MenuSceneSettings {
    struct imageName {
        static let background = "background_MenuScene"
        static let logo = "logo_MenuScene"
        
        static let buttonStartSimple = "buttonStart_simple_MenuScene"
        static let buttonStartPressed = "buttonStart_pressed_MenuScene"
        static let buttonRateUsSimple = "buttonRateUs_simple_MenuScene"
        static let buttonRateUsPressed = "buttonRateUs_pressed_MenuScene"
        static let buttonStoreSimple = "buttonStore_simple_MenuScene"
        static let buttonStorePressed = "buttonStore_pressed_MenuScene"
        static let buttonGameCenterSimple = "buttonGameCenter_simple_MenuScene"
        static let buttonGameCenterPressed = "buttonGameCenter_pressed_MenuScene"
    }
    
    struct size {
        static let background = CGSize.CGSizeWithPercent(100, height: 100)
        static let logo = CGSize.CGSizeWithPercentScaled(65.5, height: 49.5)
        
        static let buttonStart = CGSize.CGSizeWithPercentScaled(29, height: 29)
        static let buttonRateUs = CGSize.CGSizeWithPercentScaled(15, height: 15)
        static let buttonGameCenter = CGSize.CGSizeWithPercentScaled(15, height: 15)
    }
    
    struct fontSize {
        static let labelBestScore: CGFloat = 25
    }
    
    struct labelText {
        static let labelBestScore = "BEST SCORE: "
    }
    
    struct fontColor {
        static let labelBestScore = "#ffffff"
    }
    
    struct position {
        static let background = CGPoint.CGPointWithPercent(50, height: 50)
        static let logo = CGPoint.CGPointWithPercent(50, height: 80)
        
        static let buttonStart = CGPoint.CGPointWithPercent(50, height: 46)
        static let buttonRateUs = CGPoint.CGPointWithPercent(40, height: 30)
        static let buttonGameCenter = CGPoint.CGPointWithPercent(60, height: 30)
        
        static let labelBestScore = CGPoint.CGPointWithPercent(50, height: 16.5)
    }
    
    struct zPosition {
        static let background: CGFloat = 0
        static let logo: CGFloat = 2
        
        static let buttonStart: CGFloat = 1
        static let buttonRateUs: CGFloat = 1
        static let buttonGameCenter: CGFloat = 1
        
        static let labelBestScore: CGFloat = 2
    }
}

struct EndSceneSettings {
    struct imageName {
        static let background = "background_EndScene"
        static let logo = "logo_EndScene"
        static let bestScoreIndicator = "bestScoreIndicator_EndScene"
        
        static let buttonMenuSimple = "buttonMenu_simple_EndScene"
        static let buttonMenuPressed = "buttonMenu_pressed_EndScene"
        static let buttonRestartSimple = "buttonRestart_simple_EndScene"
        static let buttonRestartPressed = "buttonRestart_pressed_EndScene"
        static let buttonShareSimple = "buttonShare_simple_EndScene"
        static let buttonSharePressed = "buttonShare_pressed_EndScene"
        static let buttonGameCenterSimple = "buttonGameCenter_simple_EndScene"
        static let buttonGameCenterPressed = "buttonGameCenter_pressed_EndScene"
    }
    
    struct size {
        static let background = CGSize.CGSizeWithPercent(100, height: 100)
        static let logo = CGSize.CGSizeWithPercentScaled(65.5, height: 49.5)
        static let bestScoreIndicator = CGSize.CGSizeWithPercentScaled(15, height: 15)
        
        static let buttonMenu = CGSize.CGSizeWithPercentScaled(15, height: 15)
        static let buttonRestart = CGSize.CGSizeWithPercentScaled(15, height: 15)
        static let buttonShare = CGSize.CGSizeWithPercentScaled(15, height: 15)
        static let buttonGameCenter = CGSize.CGSizeWithPercentScaled(15, height: 15)
    }
    
    struct fontSize {
        static let labelCurrentScore: CGFloat = 45
        static let labelCurrentScoreName: CGFloat = 25
        static let labelBestScore: CGFloat = 45
        static let labelBestScoreName: CGFloat = 25
    }
    
    struct labelText {
        static let labelCurrentScoreName = "NOW"
        static let labelBestScoreName = "BEST"
    }
    
    struct fontColor {
        static let labelCurrentScore = "#ffffff"
        static let labelCurrentScoreName = "#ffffff"
        static let labelBestScore = "#ffffff"
        static let labelBestScoreName = "#ffffff"
    }
    
    struct position {
        static let background = CGPoint.CGPointWithPercent(50, height: 50)
        static let logo = CGPoint.CGPointWithPercent(50, height: 80)
        static let bestScoreIndicator = CGPoint.CGPointWithPercent(75, height: 46.5)
        
        static let buttonMenu = CGPoint.CGPointWithPercent(20, height: 25)
        static let buttonRestart = CGPoint.CGPointWithPercent(40, height: 25)
        static let buttonShare = CGPoint.CGPointWithPercent(60, height: 25)
        static let buttonGameCenter = CGPoint.CGPointWithPercent(80, height: 25)
        
        static let labelCurrentScore = CGPoint.CGPointWithPercent(30, height: 45.5)
        static let labelCurrentScoreName = CGPoint.CGPointWithPercent(30, height: 39)
        static let labelBestScore = CGPoint.CGPointWithPercent(70, height: 45.5)
        static let labelBestScoreName = CGPoint.CGPointWithPercent(70, height: 39)
    }
    
    struct zPosition {
        static let background: CGFloat = 0
        static let logo: CGFloat = 2
        static let bestScoreIndicator: CGFloat = 4
        
        static let buttonMenu: CGFloat = 3
        static let buttonRestart: CGFloat = 3
        static let buttonShare: CGFloat = 3
        static let buttonGameCenter: CGFloat = 3
        
        static let labelCurrentScore: CGFloat = 2
        static let labelCurrentScoreName: CGFloat = 2
        static let labelBestScore: CGFloat = 2
        static let labelBestScoreName: CGFloat = 2
    }
}