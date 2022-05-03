//
//  SimpleNode.swift
//  GPSwift2
//
//  Created by Vladimir Vinnik on 02.01.16.
//  Copyright © 2016 Vladimir Vinnik. All rights reserved.
//

import SpriteKit

class SimpleNode: SKSpriteNode {
    
    init(imageName: String, size: CGSize, position: CGPoint, zPosition: CGFloat) {
        super.init(texture: SKTexture.getTextureWithTrueFiltrationFromImageName(imageName), color: UIColor.clearColor(), size: size)
        self.position = position;
        self.zPosition = zPosition;
    }

    required init?(coder aDecoder: NSCoder) { fatalError("SimpleNode init(coder:) has not been implemented")}
}
