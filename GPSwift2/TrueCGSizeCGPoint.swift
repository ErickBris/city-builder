//
//  TrueCGSizeCGPoint.swift
//  GPSwift2
//
//  Created by Vladimir Vinnik on 02.01.16.
//  Copyright © 2016 Vladimir Vinnik. All rights reserved.
//

import Foundation
import SpriteKit

public extension CGSize {
    public static func CGSizeWithPercent(width: Float, height: Float) -> CGSize {
        return CGSizeMake(CGFloat(NSUserDefaults.standardUserDefaults().floatForKey("SizeWidth") / 100 * width), CGFloat(NSUserDefaults.standardUserDefaults().floatForKey("SizeHeight") / 100 * height))
    }
    
    public static func CGSizeWithPercentScaled(width: Float, height: Float) -> CGSize {
        return CGSizeMake(CGFloat(NSUserDefaults.standardUserDefaults().floatForKey("SizeWidth") / 100 * width), CGFloat(NSUserDefaults.standardUserDefaults().floatForKey("SizeWidth") / 100 * height))
    }
}

public extension CGPoint {
    public static func CGPointWithPercent(width: Float, height: Float) -> CGPoint {
        return CGPointMake(CGFloat(NSUserDefaults.standardUserDefaults().floatForKey("SizeWidth") / 100 * width), CGFloat(NSUserDefaults.standardUserDefaults().floatForKey("SizeHeight") / 100 * height))
    }
}