//
//  RandomsExtention.swift
//  GPSwift2
//
//  Created by Vladimir Vinnik on 02.01.16.
//  Copyright © 2016 Vladimir Vinnik. All rights reserved.
//

import Foundation
import CoreGraphics

public extension Int {
    public static var random:Int { get { return Int.random(Int.max) }}
    public static func random(n: Int) -> Int { return Int(arc4random_uniform(UInt32(n)))}
    public static func random(min: Int, max: Int) -> Int { return Int.random(max - min + 1) + min}
}

public extension Double {
    public static var random:Double { get { return Double(arc4random()) / 0xFFFFFFFF}}
    public static func random(min: Double, max: Double) -> Double { return Double.random * (max - min) + min}
    public static func degreesToRadians(degree: Double) -> Double { return degree * Double(M_PI) / 180.0}
}

public extension Float {
    public static var random:Float { get { return Float(arc4random()) / 0xFFFFFFFF}}
    public static func random(min min: Float, max: Float) -> Float { return Float.random * (max - min) + min}
    public static func degreesToRadians(degree: Float) -> Float { return degree * Float(M_PI) / 180.0}
}

public extension CGFloat {
    public static var randomSign:CGFloat { get { return (arc4random_uniform(2) == 0) ? 1.0 : -1.0}}
    public static var random:CGFloat { get { return CGFloat(Float.random)}}
    public static func random(min: CGFloat, max: CGFloat) -> CGFloat { return CGFloat.random * (max - min) + min}
    public static func degreesToRadians(degree: CGFloat) -> CGFloat { return degree * CGFloat(M_PI) / 180.0}
}