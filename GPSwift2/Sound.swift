//
//  Sound.swift
//  GPSwift2
//
//  Created by Vladimir Vinnik on 02.01.16.
//  Copyright © 2016 Vladimir Vinnik. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class Sound: NSObject {
    
    var getPoint = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("getPoint", ofType: "mp3")!)
    var buttonClick = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("buttonClick", ofType: "mp3")!)
    var buttonClickStart = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("buttonClickStart", ofType: "mp3")!)
    var endGame = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("endGame", ofType: "mp3")!)
    var findCompleate = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("findCompleate", ofType: "mp3")!)
    var backgroundMusic = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("backgroundMusic", ofType: "mp3")!)
    
    var audioPlayerGetPoint = AVAudioPlayer()
    var audioPlayerButtonClick = AVAudioPlayer()
    var audioPlayerButtonClickStart = AVAudioPlayer()
    var audioPlayerEndGame = AVAudioPlayer()
    var audioPlayerFindCompleate = AVAudioPlayer()
    var audioPlayerBackgroundMusic = AVAudioPlayer()
    
    override init() {
        do {
            audioPlayerGetPoint = try AVAudioPlayer(contentsOfURL: getPoint, fileTypeHint:nil)
            audioPlayerButtonClick = try AVAudioPlayer(contentsOfURL: buttonClick, fileTypeHint:nil)
            audioPlayerButtonClickStart = try AVAudioPlayer(contentsOfURL: buttonClickStart, fileTypeHint:nil)
            audioPlayerEndGame = try AVAudioPlayer(contentsOfURL: endGame, fileTypeHint:nil)
            audioPlayerFindCompleate = try AVAudioPlayer(contentsOfURL: findCompleate, fileTypeHint:nil)
            audioPlayerBackgroundMusic = try AVAudioPlayer(contentsOfURL: backgroundMusic, fileTypeHint:nil)
            
            audioPlayerGetPoint.prepareToPlay()
            audioPlayerButtonClick.prepareToPlay()
            audioPlayerButtonClickStart.prepareToPlay()
            audioPlayerFindCompleate.prepareToPlay()
            audioPlayerEndGame.prepareToPlay()
            audioPlayerBackgroundMusic.prepareToPlay()
            audioPlayerBackgroundMusic.numberOfLoops = -1 //Loop bg music
        } catch {
            print("AVAudioPlayer not initialise")
        }
    }
    
    func playSoundByName(name: String) {
        if name == "getPoint" { audioPlayerGetPoint.play()}
        else if name == "buttonClick" { audioPlayerButtonClick.play()}
        else if name == "buttonClickStart" { audioPlayerButtonClickStart.play()}
        else if name == "endGame" { audioPlayerEndGame.play()}
        else if name == "findCompleate" { audioPlayerFindCompleate.play()}
        else { print("Not found sound name")}
    }
    
    func playBackgroundMusic() { audioPlayerBackgroundMusic.play()}
    func stopbackgroundMusic() { audioPlayerBackgroundMusic.stop()}
}
