//
//  ButtonNode.swift
//  GPSwift2
//
//  Created by Vladimir Vinnik on 02.01.16.
//  Copyright © 2016 Vladimir Vinnik. All rights reserved.
//

import SpriteKit

class ButtonNode: SKSpriteNode {

    var currentButtonStateIsPressed = false;
    
    @IBOutlet var textureSimple: SKTexture?
    @IBOutlet var texturePressed: SKTexture?
    
    init(imageSimpleName: String, imagePressedName: String, size: CGSize, position: CGPoint, zPosition: CGFloat) {
        super.init(texture: SKTexture.getTextureWithTrueFiltrationFromImageName(imageSimpleName), color: UIColor.clearColor(), size: size)
        self.position = position;
        self.zPosition = zPosition;
        
        textureSimple = SKTexture.getTextureWithTrueFiltrationFromImageName(imageSimpleName)
        texturePressed = SKTexture.getTextureWithTrueFiltrationFromImageName(imagePressedName)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("SimpleNode init(coder:) has not been implemented")}
    
    //MARK: Work with button
    
    func changeButtonStateToSimpleState(state: Bool) {
        if state { self.texture = textureSimple}
        else { self.texture = texturePressed}
    }
}
