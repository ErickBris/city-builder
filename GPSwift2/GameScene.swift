//
//  GameScene.swift
//  GPSwift2
//
//  Created by Vladimir Vinnik on 25.12.15.
//  Copyright (c) 2015 Vladimir Vinnik. All rights reserved.
//

import SpriteKit

class GameScene: GlobalScene {
    
    //Game stats
    var score: Int = 0
    var speedOfBlocks: Double = GameProcessSettings.speedOfBlocks
    
    var gameIsPlay: Bool = true
    var tutorialShow: Bool = false
    
    var blockLine1Array = [BlockNode]()
    var blockLine2Array = [BlockNode]()
    var blockLine3Array = [BlockNode]()
    var blockLine4Array = [BlockNode]()
    var blockLine5Array = [BlockNode]()
    
    //Timers
    @IBOutlet var timerForChangeSceneAfterDead: NSTimer?
    
    //Nodes
    @IBOutlet var bgBack: SimpleNode?
    @IBOutlet var bgMiddle: SimpleNode?
    @IBOutlet var bgFront: SimpleNode?
    @IBOutlet var tutorial: SimpleNode?
    
    @IBOutlet var labelScore: SimpleLabel?
    
    @IBOutlet var block: BlockNode?
    
    var swipeLeft: UISwipeGestureRecognizer?
    var swipeRight: UISwipeGestureRecognizer?
    var swipeDown: UISwipeGestureRecognizer?
    var swipeUp: UISwipeGestureRecognizer?
    
    //MARK: Init
    
    override func didMoveToView(view: SKView) {
        //Init componenets
        initComponents()
        if GlobalSettings.iAdShow.gameScene { NSNotificationCenter.defaultCenter().postNotificationName("iAdShow", object: nil)}
        else { NSNotificationCenter.defaultCenter().postNotificationName("iAdHide", object: nil)}
        
        if GlobalSettings.chartboostShow.gameScene { Chartboost.showInterstitial(CBLocationDefault)}
        
        if GlobalSettings.adMobShow.gameScene { NSNotificationCenter.defaultCenter().postNotificationName("adMobShow", object: nil)}
        else { NSNotificationCenter.defaultCenter().postNotificationName("adMobHide", object: nil)}
        
        if GlobalSettings.adMobInterstitialCall.gameScene { NSNotificationCenter.defaultCenter().postNotificationName("adMobInterstitialCall", object: nil)}
        
        //Init gestures
        swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(inputSwipeLeft))
        swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(inputSwipeRight))
        swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(inputSwipeDown))
        swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(inputSwipeUp))
        swipeLeft?.direction = UISwipeGestureRecognizerDirection.Left
        swipeRight?.direction = UISwipeGestureRecognizerDirection.Right
        swipeDown?.direction = UISwipeGestureRecognizerDirection.Down
        swipeUp?.direction = UISwipeGestureRecognizerDirection.Up
        self.view!.addGestureRecognizer(swipeLeft!)
        self.view!.addGestureRecognizer(swipeRight!)
        self.view!.addGestureRecognizer(swipeDown!)
        self.view!.addGestureRecognizer(swipeUp!)
        
        sounds.playBackgroundMusic()

        //Show tutorial
        if NSUserDefaults.standardUserDefaults().boolForKey("ShowTutorial") {
            tutorialShow = true;
            gameIsPlay = false;
        }
        
        //Init nodes
        setInterface()
        
        startGame()
    }
    
    //MARK: Set nodes
    
    //Interface nodes
    
    func setInterface() {
        bgBack = SimpleNode(imageName: GameSceneSettings.imageName.bgBack, size: GameSceneSettings.size.bgBack, position: GameSceneSettings.position.bgBack, zPosition: GameSceneSettings.zPosition.bgBack)
        bgMiddle = SimpleNode(imageName: GameSceneSettings.imageName.bgMiddle, size: GameSceneSettings.size.bgMiddle, position: GameSceneSettings.position.bgMiddle, zPosition: GameSceneSettings.zPosition.bgMiddle)
        bgFront = SimpleNode(imageName: GameSceneSettings.imageName.bgFront, size: GameSceneSettings.size.bgFront, position: GameSceneSettings.position.bgFront, zPosition: GameSceneSettings.zPosition.bgFront)
        tutorial = SimpleNode(imageName: GameSceneSettings.imageName.tutorial, size: GameSceneSettings.size.tutorial, position: GameSceneSettings.position.tutorial, zPosition: GameSceneSettings.zPosition.tutorial)
        
        labelScore = SimpleLabel(text: "0", fontSize: GameSceneSettings.fontSize.labelScore, fontColorHex: GameSceneSettings.fontColor.labelScore, position: GameSceneSettings.position.labelScore, zPosition: GameSceneSettings.zPosition.labelScore)
        
        bgMiddle?.runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.scaleTo(1.15, duration: GameProcessSettings.speedOfAnimationMiddleBackground / 2),
                SKAction.scaleTo(1.0, duration: GameProcessSettings.speedOfAnimationMiddleBackground / 2)])))
        
        self.addChild(bgBack!)
        self.addChild(bgMiddle!)
        self.addChild(bgFront!)
        if tutorialShow { self.addChild(tutorial!)}
        
        self.addChild(labelScore!)
    }
    
    //Game nodes
    
    func setNewBlock() {
        if gameIsPlay {
            block = BlockNode()
            block?.moveStart(withSpeed: speedOfBlocks)
            self.addChild(block!)
        }
    }
    
    //MARK: Game process
    
    func startGame() {
        if (gameIsPlay) {
            setNewBlock()
        }
    }
    
    func endGame() {
        if (gameIsPlay) {
            //Change stats
            gameIsPlay = false
            makeScreenShot()
            sounds.playSoundByName("endGame")
            
            //Save score
            NSUserDefaults.standardUserDefaults().setInteger(score, forKey: "CurrentScore")
            if score > NSUserDefaults.standardUserDefaults().integerForKey("BestScore") {
                NSUserDefaults.standardUserDefaults().setInteger(score, forKey: "BestScore")
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "NewBestScore")
                NSNotificationCenter.defaultCenter().postNotificationName("submitScore", object: nil)
            }
            else {
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: "NewBestScore")
            }
            
            //Change scene after time
            timerForChangeSceneAfterDead = NSTimer.scheduledTimerWithTimeInterval(Double(1), target: self, selector: #selector(GameScene.changeScene), userInfo: nil, repeats: false)
        }
    }
    
    func changeScene() {
        sounds.stopbackgroundMusic()
        changeSceneToSceneName("EndScene", withAnimationName: "MoveDown")
    }
    
    func changeScoreByValue(value: Int) {
        if gameIsPlay {
            score += value
            labelScore?.text = String(score)
        }
    }
    
    func changeSpeed(faster faster: Bool) {
        if gameIsPlay {
            if faster {
                speedOfBlocks -= (speedOfBlocks / 100) * GameProcessSettings.changeGenerateBlocksByPercent
            }
            else {
                speedOfBlocks += (speedOfBlocks / 100) * GameProcessSettings.changeGenerateBlocksByPercent
            }
        }
    }
    
    func swipeByDirection(direction: String) {
        if gameIsPlay {
            if direction == "Left" {
                if block?.currenPositionLine > 1 {
                    if possibleToSetInArray(getArrayAtNumber((block?.currenPositionLine)! - 1)) {
                        block?.moveTo(true)
                    }
                }
            }
            else if direction == "Right" {
                if block?.currenPositionLine < 5 {
                    if possibleToSetInArray(getArrayAtNumber((block?.currenPositionLine)! + 1)) {
                        block?.moveTo(false)
                    }
                }
            }
            else {
                if block?.position.y < CGFloat(GlobalSettings.sizeHeight) - (block?.size.height)! {
                    stopBlockAndGetNew()
                }
            }
        }
    }
    
    //MARK: Work with array
    
    func addBlockToArray() {
        switch block!.currenPositionLine {
        case 1:
            blockLine1Array.append(block!)
        case 2:
            blockLine2Array.append(block!)
        case 3:
            blockLine3Array.append(block!)
        case 4:
            blockLine4Array.append(block!)
        default:
            blockLine5Array.append(block!)
        }
    }
    
    func sortAllArrays() {
        sortArray(blockLine1Array)
        sortArray(blockLine2Array)
        sortArray(blockLine3Array)
        sortArray(blockLine4Array)
        sortArray(blockLine5Array)
    }
    
    func getArrayAtNumber(number: Int) -> [BlockNode] {
        switch number {
        case 1:
            return blockLine1Array
        case 2:
            return blockLine2Array
        case 3:
            return blockLine3Array
        case 4:
            return blockLine4Array
        default:
            return blockLine5Array
        }
    }
    
    func sortArray(array: [BlockNode]) {
        for (index, value) in array.enumerate() {
            let currentBlock = value
            currentBlock.runAction(SKAction.moveToY(GameSceneSettings.position.lineBorder + ((block?.size.height)! * CGFloat(index)), duration: 0.1))
        }
    }
    
    func getLastBlockPositionYInCurrentBlockLine() -> CGFloat {
        switch block!.currenPositionLine {
        case 1:
            return getPositionYInLastBlockInArray(blockLine1Array)
        case 2:
            return getPositionYInLastBlockInArray(blockLine2Array)
        case 3:
            return getPositionYInLastBlockInArray(blockLine3Array)
        case 4:
            return getPositionYInLastBlockInArray(blockLine4Array)
        default:
            return getPositionYInLastBlockInArray(blockLine5Array)
        }
    }
    
    func getPositionYInLastBlockInArray(array: [BlockNode]) -> CGFloat {
        if array.count != 0 {
            let currentBlock = array[array.count - 1]
            return currentBlock.position.y
        }
        else {
            return 0
        }
    }
    
    func blockContactAnotherBlocksInHimLine() -> Bool {
        if block?.position.y <= getLastBlockPositionYInCurrentBlockLine() + (block?.size.height)! {
            return true
        }
        else {
            return false
        }
    }
    
    func findLoseIfBlockOnFloor() {
        if getPositionYInLastBlockInArray(blockLine1Array) >= CGFloat(GlobalSettings.sizeHeight) - (block?.size.height)! {
            endGame()
        }
        if getPositionYInLastBlockInArray(blockLine2Array) >= CGFloat(GlobalSettings.sizeHeight) - (block?.size.height)! {
            endGame()
        }
        if getPositionYInLastBlockInArray(blockLine3Array) >= CGFloat(GlobalSettings.sizeHeight) - (block?.size.height)! {
            endGame()
        }
        if getPositionYInLastBlockInArray(blockLine4Array) >= CGFloat(GlobalSettings.sizeHeight) - (block?.size.height)! {
            endGame()
        }
        if getPositionYInLastBlockInArray(blockLine5Array) >= CGFloat(GlobalSettings.sizeHeight) - (block?.size.height)! {
            endGame()
        }
    }
    
    //MARK: Find block to remove
    
    //Vertical
    func findBlocksToRemoveVertical() {
        findCompleateInArray(&blockLine1Array)
        findCompleateInArray(&blockLine2Array)
        findCompleateInArray(&blockLine3Array)
        findCompleateInArray(&blockLine4Array)
        findCompleateInArray(&blockLine5Array)
    }
    
    func findCompleateInArray(inout array: [BlockNode]) {
        var goOneMoreTime = false
        repeat {
            goOneMoreTime = false
            
            for i in 0..<array.count {
                var findNow = false
                let currentBlock = array[i]
                
                if i + 1 < array.count {
                    for j in (i + 1)..<array.count {
                        let secondBlock = array[j]
                        
                        if !currentBlock.blockToRemove && !secondBlock.blockToRemove {
                            if currentBlock.currentColor != secondBlock.currentColor {
                                if (j - i) >= GameProcessSettings.needToPlaceInOne {
                                    removeBlocksInArray(&array, from: i, to: j - 1)
                                    
                                    findNow = true
                                    goOneMoreTime = true
                                }
                                
                                break
                            }
                            else {
                                if j == array.count - 1 {
                                    if (j - i) >= GameProcessSettings.needToPlaceInOne - 1 {
                                        removeBlocksInArray(&array, from: i, to: j)
                                        
                                        findNow = true
                                        goOneMoreTime = true
                                        
                                        break
                                    }
                                }
                            }
                        }
                        else {
                            break
                        }
                    }
                }
                
                if findNow { break}
            }
        } while goOneMoreTime
    }
    
    func removeBlocksInArray(inout array: [BlockNode], from: Int, to: Int) {
        for i in from...to {
            let currentBlock = array[i]
            currentBlock.makeItAvaliableToRemove()
        }
    }
    
    //Horizontal
    func findBlocksToRemoveHorizontal() {
        var arrayWithAllLines = [blockLine1Array,
                                 blockLine2Array,
                                 blockLine3Array,
                                 blockLine4Array,
                                 blockLine5Array]
        
        var goOneMoreTime = false
        repeat {
            goOneMoreTime = false
            
            let maximalHeightLines = getMaximalHeightOfLines()
            if maximalHeightLines > 0 {
                var findNow = false
                
                for i in 0..<maximalHeightLines {
                    for j in 0..<arrayWithAllLines.count {
                        let currentArray = arrayWithAllLines[j]
                        if i < currentArray.count {
                            let currentObject = currentArray[i]
                            
                            if j + 1 < arrayWithAllLines.count {
                                for k in (j + 1)..<arrayWithAllLines.count {
                                    let secondArray = arrayWithAllLines[k]
                                    if i < secondArray.count {
                                        let secondObject = secondArray[i]
                                        
                                        if !currentObject.blockToRemove && !secondObject.blockToRemove {
                                            if currentObject.currentColor != secondObject.currentColor  {
                                                if (k - j) >= GameProcessSettings.needToPlaceInOne {
                                                    for f in j..<k {
                                                        removeObjectAtArrayByNumber(f, atIndex: i)
                                                    }
                                                    
                                                    findNow = true
                                                    goOneMoreTime = true
                                                }
                                                
                                                break
                                            }
                                            else {
                                                if k == arrayWithAllLines.count - 1 {
                                                    if (k - j) >= GameProcessSettings.needToPlaceInOne - 1 {
                                                        for f in j...k {
                                                            removeObjectAtArrayByNumber(f, atIndex: i)
                                                        }
                                                        
                                                        findNow = true
                                                        goOneMoreTime = true
                                                        
                                                        break
                                                    }
                                                }
                                            }
                                        }
                                        else {
                                            break
                                        }
                                    }
                                    else {
                                        break
                                    }
                                }
                            }
                            if findNow { break}
                        }
                    }
                    if findNow { break}
                }
            }
        } while goOneMoreTime
    }

    func getMaximalHeightOfLines() -> Int {
        var maximalHeight = blockLine1Array.count
        if maximalHeight < blockLine2Array.count { maximalHeight = blockLine2Array.count}
        if maximalHeight < blockLine3Array.count { maximalHeight = blockLine3Array.count}
        if maximalHeight < blockLine4Array.count { maximalHeight = blockLine4Array.count}
        if maximalHeight < blockLine5Array.count { maximalHeight = blockLine5Array.count}
        
        return maximalHeight
    }
    
    func removeObjectAtArrayByNumber(number: Int, atIndex index: Int) {
        switch number {
        case 0:
            let currentObject = blockLine1Array[index]
            currentObject.makeItAvaliableToRemove()
        case 1:
            let currentObject = blockLine2Array[index]
            currentObject.makeItAvaliableToRemove()
        case 2:
            let currentObject = blockLine3Array[index]
            currentObject.makeItAvaliableToRemove()
        case 3:
            let currentObject = blockLine4Array[index]
            currentObject.makeItAvaliableToRemove()
        default:
            let currentObject = blockLine5Array[index]
            currentObject.makeItAvaliableToRemove()
        }
    }
    
    //All
    
    func removeAvaliableBlocks() {
        var itsBeenRemove = false
        
        itsBeenRemove = removeAvaliableBlocksInArray(&blockLine1Array)
        itsBeenRemove = removeAvaliableBlocksInArray(&blockLine2Array)
        itsBeenRemove = removeAvaliableBlocksInArray(&blockLine3Array)
        itsBeenRemove = removeAvaliableBlocksInArray(&blockLine4Array)
        itsBeenRemove = removeAvaliableBlocksInArray(&blockLine5Array)
        
        if itsBeenRemove { changeSpeed(faster: false)}
    }
    
    func removeAvaliableBlocksInArray(inout array: [BlockNode]) -> Bool {
        var itsBeenRemove = false
        
        var arrayBeenChanged = false
        repeat {
            arrayBeenChanged = false
            
            for i in 0..<array.count {
                let currentBlock = array[i]
                if currentBlock.blockToRemove {
                    currentBlock.remove()
                    array.removeAtIndex(i)
                    arrayBeenChanged = true
                    itsBeenRemove = true
                    
                    changeScoreByValue(GameProcessSettings.changeScoreForOneBlockInHorizontalOrVertical)
                    sounds.playSoundByName("findCompleate")
                    
                    break
                }
            }
        } while arrayBeenChanged == true
        
        return itsBeenRemove
    }
    
    //MARK: Work with block
    
    func stopBlockAndGetNew() {
        block?.stopMoving()
        addBlockToArray()
        
        findBlocksToRemoveVertical()
        findBlocksToRemoveHorizontal()
        removeAvaliableBlocks()
        sortAllArrays()
        
        findLoseIfBlockOnFloor()
        
        changeScoreByValue(GameProcessSettings.changeScoreBySetBlock)
        setNewBlock()
        sounds.playSoundByName("getPoint")
        
        changeSpeed(faster: true)
    }
    
    func possibleToSetInArray(array: [BlockNode]) -> Bool {
        if block?.position.y >= getPositionYInLastBlockInArray(array) + (block?.size.height)! {
            return true
        }
        else {
            return false
        }
    }
    
    //MARK: Update
    
    override func update(currentTime: NSTimeInterval) {
        if gameIsPlay {
            if block != nil {
                if block?.position.y <= GameSceneSettings.position.lineBorder {
                    stopBlockAndGetNew()
                }
                
                if blockContactAnotherBlocksInHimLine() {
                    stopBlockAndGetNew()
                }
            }
        }
    }
    
    //MARK: Input
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if !gameIsPlay {
            if tutorialShow {
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: "ShowTutorial")
                gameIsPlay = true
                tutorialShow = false
                tutorial?.removeFromParent()
                
                startGame();
            }
        }
    }
    
    func inputSwipeLeft() {
        swipeByDirection("Left")
    }
    
    func inputSwipeRight() {
        swipeByDirection("Right")
    }
    
    func inputSwipeDown() {
        swipeByDirection("Down")
    }
    
    func inputSwipeUp() {
        swipeByDirection("Up")
    }
}
