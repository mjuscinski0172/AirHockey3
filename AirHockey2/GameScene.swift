//
//  GameScene.swift
//  AirHockey2
//
//  Created by student3 on 5/4/17.
//  Copyright © 2017 John Hersey High School. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit


let puckCategory: UInt32 = 0x1 << 0
let bottomCategory: UInt32 = 0x1 << 1
let topCategory: UInt32 = 0x1 << 2
let leftCategory: UInt32 = 0x1 << 3
let rightCategory: UInt32 = 0x1 << 4
let paddleCategory: UInt32 = 0x1 << 5
let leftGoalCategory: UInt32 = 0x1 << 6
let rightGoalCategory: UInt32 = 0x1 << 7

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var rightPaddle = SKSpriteNode()
    var leftPaddle = SKSpriteNode()
    var puck = SKSpriteNode()
    var rightGoal = SKSpriteNode()
    var leftGoal = SKSpriteNode()
    var leftScore = SKLabelNode()
    var rightScore = SKLabelNode()
    var leftScoreCounter = 0
    var rightScoreCounter = 0
    var winnerLabel = SKLabelNode()
    
    var oneOrTwo = 0
    
    override func didMove(to view: SKView)
    {
        rightPaddle = self.childNode(withName: "rightPaddle") as! SKSpriteNode
        leftPaddle = self.childNode(withName: "leftPaddle") as! SKSpriteNode
        puck = self.childNode(withName: "puck") as! SKSpriteNode
        rightGoal = self.childNode(withName: "rightGoal") as! SKSpriteNode
        leftGoal = self.childNode(withName: "leftGoal") as! SKSpriteNode
        leftScore = self.childNode(withName: "leftScore") as! SKLabelNode
        rightScore = self.childNode(withName: "rightScore") as! SKLabelNode
        winnerLabel = self.childNode(withName: "winnerLabel") as! SKLabelNode
                
        physicsWorld.contactDelegate = self
        
        let bottomLeft = CGPoint(x: frame.origin.x + 25, y: frame.origin.y)
        let bottomRight = CGPoint(x: -frame.origin.x - 25, y: frame.origin.y)
        let topLeft = CGPoint(x: frame.origin.x, y: 284)
        let topRight = CGPoint(x: -frame.origin.x, y: 284)
        
        let bottom = SKSpriteNode()
        bottom.name = "bottom"
        bottom.physicsBody = SKPhysicsBody(edgeFrom: bottomLeft, to: bottomRight)
        
        let left = SKSpriteNode()
        left.name = "left"
        left.physicsBody = SKPhysicsBody(edgeFrom: bottomLeft, to: topLeft)
        
        let top = SKSpriteNode()
        top.name = "top"
        top.physicsBody = SKPhysicsBody(edgeFrom: topLeft, to: topRight)
        
        let right = SKSpriteNode()
        right.name = "right"
        right.physicsBody = SKPhysicsBody(edgeFrom: topRight, to: bottomRight)
        
        addChild(bottom)
        addChild(left)
        addChild(top)
        addChild(right)
        
        leftPaddle.physicsBody?.categoryBitMask = paddleCategory
        rightPaddle.physicsBody?.categoryBitMask = paddleCategory
        puck.physicsBody?.categoryBitMask = puckCategory
        leftGoal.physicsBody?.categoryBitMask = leftGoalCategory
        rightGoal.physicsBody?.categoryBitMask = rightGoalCategory
        
        puck.physicsBody?.contactTestBitMask = paddleCategory | leftGoalCategory | rightGoalCategory
//        
//        let alert = UIAlertController(title: "One or Two Players?", message: nil, preferredStyle: .alert)
//        let oneAction = UIAlertAction(title: "One Player", style: .default) { (UIAlertAction) in
//            self.oneOrTwo = 1
//        }
//        let twoAction = UIAlertAction(title: "Two Players", style: .default) { (UIAlertAction) in
//            self.oneOrTwo = 2
//        }
//        alert.addAction(oneAction)
//        alert.addAction(twoAction)
//        self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches
        {
            let location = touch.location(in: self)
            if location.x > 0 && location.y < 249 && location.x < -frame.origin.x - 25
            {
                if oneOrTwo == 2 {
                    rightPaddle.run(SKAction.move(to: location, duration: 0.1))
                }
                else if oneOrTwo == 1 {
                    
                }
            }
            
            if location.x < 0 && location.y < 249 && location.x > frame.origin.x + 25
            {
                leftPaddle.run(SKAction.move(to: location, duration: 0.1))
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches
        {
            let location = touch.location(in: self)
            
            if location.x > 0 && location.y < 249
            {
                rightPaddle.run(SKAction.move(to: location, duration: 0.1))
            }
            
            if location.x < 0 && location.y < 249
            {
                leftPaddle.run(SKAction.move(to: location, duration: 0.1))
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == rightGoalCategory {
            leftScoreCounter += 1
            leftScore.text = "\(leftScoreCounter)"
            if leftScoreCounter == 2 {
                let alert = UIAlertController(title: "Player One Wins", message: nil, preferredStyle: .alert)
                let backToMenu = UIAlertAction(title: "Back to Main Menu", style: .default, handler: { (UIAlertAction) in
                    self.view?.window?.rootViewController?.performSegue(withIdentifier: "gameSceneTwoSegue", sender: self)
                })
                let resetButton = UIAlertAction(title: "Play Again", style: .default, handler: { (UIAlertAction) in
                    self.reset()
                })
                alert.addAction(backToMenu)
                alert.addAction(resetButton)
                print(self.view?.window?.rootViewController)
                self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
                print(self.view?.window?.rootViewController)
            }
            else {
                    puck.run(SKAction.move(to: CGPoint(x: 150, y: -50), duration: 0.0))
                 }
        }
            
        else if contact.bodyA.categoryBitMask == leftGoalCategory {
            rightScoreCounter += 1
            rightScore.text = "\(rightScoreCounter)"
            if rightScoreCounter == 2 {
                let alert = UIAlertController(title: "Player Two Wins!", message: nil, preferredStyle: .alert)
                let backToMenu = UIAlertAction(title: "Back to Main Menu", style: .default , handler: { (UIAlertAction) in
                })
                let resetButton = UIAlertAction(title: "Play Again", style: .default, handler: { (UIAlertAction) in
                    self.reset()
                })
                alert.addAction(backToMenu)
                alert.addAction(resetButton)
                print(self.view?.window?.rootViewController)
                self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
                print(self.view?.window?.rootViewController)
            }
                
            else {
                puck.run(SKAction.move(to: CGPoint(x: -150, y: -50), duration: 0.0))
                }
            }
        }
    
    func reset() {
        let delayInSeconds = 4.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            self.winnerLabel.text = "Play!"
            self.leftScore.text = "0"
            self.rightScore.text = "0"
            self.leftScoreCounter = 0
            self.rightScoreCounter = 0
            self.oneOrTwo = 0
            self.puck.run(SKAction.move(to: CGPoint(x: 0, y: -50), duration: 0))
            self.rightPaddle.run(SKAction.move(to: CGPoint(x: 410, y: -50), duration: 0))
            self.leftPaddle.run(SKAction.move(to: CGPoint(x: -410, y: -50), duration: 0))
//            let alert = UIAlertController(title: "One or Two Players?", message: nil, preferredStyle: .alert)
//            let oneAction = UIAlertAction(title: "One Player", style: .default) { (UIAlertAction) in
//                self.oneOrTwo = 1
//            }
//            let twoAction = UIAlertAction(title: "Two Players", style: .default) { (UIAlertAction) in
//                self.oneOrTwo = 2
//            }
//            alert.addAction(oneAction)
//            alert.addAction(twoAction)
//            self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    var counter = 1
    var timerCounter = 120
    var presentedOrNo = false
    
    override func update(_ currentTime: TimeInterval) {

        if oneOrTwo == 0{
            let alert = UIAlertController(title: "One or Two Players?", message: nil, preferredStyle: .alert)
            let oneAction = UIAlertAction(title: "One Player", style: .default) { (UIAlertAction) in
                self.oneOrTwo = 1
            }
            let twoAction = UIAlertAction(title: "Two Players", style: .default) { (UIAlertAction) in
                self.oneOrTwo = 2
            }
            alert.addAction(oneAction)
            alert.addAction(twoAction)
            if presentedOrNo == false
            {
                self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
                presentedOrNo = true
            }
        }
        if oneOrTwo != 0 {
            counter += 1
        }
        if puck.position.x < 0
        {
            rightPaddle.run(SKAction.move(to: CGPoint(x: 410, y: puck.position.y), duration: 0.2))
        }
            
        else if puck.position.x > 0
        {
            rightPaddle.run(SKAction.move(to: CGPoint(x: puck.position.x, y: puck.position.y), duration: 0.2))
        }
        
        if counter % 14 == 0 && timerCounter != 0
        {
            if counter == 14 {
                winnerLabel.text = "Ready!"
            }
            else if counter == 28 {
                winnerLabel.text = "Set!"
            }
            else if counter == 42 {
                winnerLabel.text = "GO!"
            }
            else {
                timerCounter -= 1
                winnerLabel.text = "\(timerCounter)"
            }
        }
        else if timerCounter == 0
        {
            if rightScoreCounter > leftScoreCounter
            {
                winnerLabel.text = "Player 2 Wins!"
                reset()
            }
            else if leftScoreCounter > rightScoreCounter
            {
                winnerLabel.text = "Player 1 Wins!"
                reset()
            }
            else {
                reset()
            }
        }
    }
}
