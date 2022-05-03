//
//  GlobalScene.swift
//  GPSwift2
//
//  Created by Vladimir Vinnik on 02.01.16.
//  Copyright © 2016 Vladimir Vinnik. All rights reserved.
//

import SpriteKit

class GlobalScene: SKScene {
    
    //MARK: Initital components
    @IBOutlet var sounds: Sound!
    
    func initComponents() {
        sounds = Sound()
    }
    
    //MARK: Screen shot
    
    func makeScreenShot() {
        //Create the image
        UIGraphicsBeginImageContext(CGSizeMake(frame.size.width, frame.size.height))
        self.view?.drawViewHierarchyInRect(frame, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        //Save screen shot
        NSUserDefaults.standardUserDefaults().setObject(UIImagePNGRepresentation(image), forKey: "CurrentScreenShot");
    }

    //MARK: Change scene
    
    func changeSceneToSceneName(name: String, withAnimationName animationName: String) {
        let scene = getSceneByName(name)
        let animation = getAnimationForChangeSceneByName(animationName)
        
        if scene != nil {
            if animation != nil { self.view?.presentScene(scene!, transition: animation!)}
            else { self.view?.presentScene(scene!)}
        }
    }
    
    func getSceneByName(name: String) -> SKScene? {
        if name == "GameScene" { return GameScene(size: self.size)}
        else if name == "MenuScene" { return MenuScene(size: self.size)}
        else if name == "EndScene" { return EndScene(size: self.size)}
        else { return nil}
    }
    
    func getAnimationForChangeSceneByName(name: String) -> SKTransition? {
        if name == "Fade" { return SKTransition.fadeWithDuration(1)}
        else if name == "MoveDown" { return SKTransition.moveInWithDirection(SKTransitionDirection.Down, duration: 1)}
        else if name == "MoveUp" { return SKTransition.moveInWithDirection(SKTransitionDirection.Up, duration: 1)}
        else { return nil}
    }
}
