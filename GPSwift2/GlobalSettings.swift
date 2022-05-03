//
//  GlobalSettings.swift
//  GPSwift2
//
//  Created by Vladimir Vinnik on 02.01.16.
//  Copyright © 2016 Vladimir Vinnik. All rights reserved.
//

import Foundation

struct GlobalSettings {
    static let shareText = "See my score in this game!"
    static let linkToRateUs = "LINK TO RATE US"
    static let gameCenterOn = true
    static let leaderboardId = "LEADERBOARD ID"
    static let chartboostAppId = "5446f5d31873da0ce13dd05a"
    static let chartboostAppSignature = "d590559e2dfdeb8c237a157254a856325014501b"
    static let adMobBannerUnitID = "ca-app-pub-3940256099942544/2934735716"
    static let adMobTestDeviceID = "850fa108ad3ca507d42404ca68926476"
    
    static let nonFilteredImagesInGame = false
    
    static let fontNameInGame = "HelveticaNeue-Thin"
    
    static let sizeWidth: Float = NSUserDefaults.standardUserDefaults().floatForKey("SizeWidth")
    static let sizeHeight: Float = NSUserDefaults.standardUserDefaults().floatForKey("SizeHeight")
    
    struct iAdShow {
        static let gameScene = false;
        static let storeScene = false;
        static let menuScene = false;
        static let endScene = true;
    }
    
    struct chartboostShow {
        static let gameScene = false;
        static let storeScene = true;
        static let menuScene = false;
        static let endScene = true;
    }
    
    struct adMobShow {
        static let gameScene = false;
        static let storeScene = true;
        static let menuScene = false;
        static let endScene = false;
    }
    
    struct adMobInterstitialCall {
        static let gameScene = false;
        static let storeScene = false;
        static let menuScene = false;
        static let endScene = true;
    }
}