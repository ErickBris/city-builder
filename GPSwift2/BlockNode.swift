//
//  PlayerNode.swift
//  GPSwift2
//
//  Created by Vladimir Vinnik on 02.01.16.
//  Copyright © 2016 Vladimir Vinnik. All rights reserved.
//

import SpriteKit

class BlockNode: SKSpriteNode {
    
    var currentColor: Int = 0
    var currenPositionLine: Int = 0
    
    var blockToRemove: Bool = false
    
    init() {
        super.init(texture: SKTexture.getTextureWithTrueFiltrationFromImageName(GameSceneSettings.imageName.block1), color: UIColor.clearColor(), size: GameSceneSettings.size.block)
        self.position = GameSceneSettings.position.block
        self.zPosition = GameSceneSettings.zPosition.block
        
        getRandomColor()
        setToRandomPosition()
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("SimpleNode init(coder:) has not been implemented")}
    
    //Positions
    
    func setToRandomPosition() {
        setToPositionByNumber(positionNumber: Int.random(1, max: 5), withAnimation: false)
    }
    
    func setToPositionByNumber(positionNumber number: Int, withAnimation: Bool) {
        var position: CGPoint
        switch number {
        case 1:
            position = CGPointMake(GameSceneSettings.position.line1Width, self.position.y)
        case 2:
            position = CGPointMake(GameSceneSettings.position.line2Width, self.position.y)
        case 3:
            position = CGPointMake(GameSceneSettings.position.line3Width, self.position.y)
        case 4:
            position = CGPointMake(GameSceneSettings.position.line4Width, self.position.y)
        default:
            position = CGPointMake(GameSceneSettings.position.line5Width, self.position.y)
        }
        
        if withAnimation {
            self.runAction(SKAction.group([
                SKAction.moveToX(position.x, duration: 0.05),
                SKAction.sequence([
                    SKAction.scaleXTo(0.6, duration: 0.025),
                    SKAction.scaleXTo(1.0, duration: 0.025)])]))
        }
        else { self.position = position}
        
        currenPositionLine = number
    }
    
    //Color
    
    func getRandomColor() {
        currentColor = Int.random(1, max: 5)
        
        if currentColor == 1 { self.texture = SKTexture.getTextureWithTrueFiltrationFromImageName(GameSceneSettings.imageName.block1)}
        else if currentColor == 2 { self.texture = SKTexture.getTextureWithTrueFiltrationFromImageName(GameSceneSettings.imageName.block2)}
        else if currentColor == 3 { self.texture = SKTexture.getTextureWithTrueFiltrationFromImageName(GameSceneSettings.imageName.block3)}
        else if currentColor == 4 { self.texture = SKTexture.getTextureWithTrueFiltrationFromImageName(GameSceneSettings.imageName.block4)}
        else { self.texture = SKTexture.getTextureWithTrueFiltrationFromImageName(GameSceneSettings.imageName.block5)}
    }
    
    //Moving
    
    func moveTo(left: Bool) {
        if left {
            if currenPositionLine > 1 {
                setToPositionByNumber(positionNumber: currenPositionLine - 1, withAnimation: true)
            }
        }
        else {
            if currenPositionLine < 5 {
                setToPositionByNumber(positionNumber: currenPositionLine + 1, withAnimation: true)
            }
        }
    }
    
    func moveStart(withSpeed speed: Double) {
        self.runAction(SKAction.moveToY(self.position.y - CGFloat(GlobalSettings.sizeHeight * 2), duration: speed), withKey: "movingDown")
    }
    
    func stopMoving() {
        self.removeActionForKey("movingDown")
    }
    
    func makeItAvaliableToRemove() {
        blockToRemove = true;
    }
    
    func remove() {
        self.runAction(SKAction.sequence([
            SKAction.group([
                SKAction.scaleTo(2, duration: 0.05),
                SKAction.fadeOutWithDuration(0.1)]),
            SKAction.removeFromParent()]))
    }
    
}
