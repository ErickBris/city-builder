//
//  GameProgressSettings.swift
//  GPSwift2
//
//  Created by Vladimir Vinnik on 02.01.16.
//  Copyright © 2016 Vladimir Vinnik. All rights reserved.
//

import Foundation
import SpriteKit

struct GameProcessSettings {
    
    //Game scene
    static let speedOfBlocks: Double = 3.1
    static let changeGenerateBlocksByPercent: Double = 0.75
    
    static let speedOfAnimationMiddleBackground: Double = 2.4
    
    static let changeScoreBySetBlock: Int = 1
    static let changeScoreForOneBlockInHorizontalOrVertical: Int = 5
    
    static let needToPlaceInOne: Int = 3
}