//
//  SimpleLabel.swift
//  GPSwift2
//
//  Created by Vladimir Vinnik on 02.01.16.
//  Copyright © 2016 Vladimir Vinnik. All rights reserved.
//

import SpriteKit

class SimpleLabel: SKLabelNode {
    
    init(text: String, fontSize: CGFloat, fontColorHex: String, position: CGPoint, zPosition: CGFloat) {
        super.init()
        self.fontName = GlobalSettings.fontNameInGame
        self.text = text
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad { self.fontSize = fontSize * 2}
        else { self.fontSize = fontSize}
        self.fontColor = UIColor(hexString: fontColorHex)
        self.position = position;
        self.zPosition = zPosition;
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("SimpleNode init(coder:) has not been implemented")}
}
