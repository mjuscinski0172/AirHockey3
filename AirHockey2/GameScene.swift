//
//  GameScene.swift
//  AirHockey2
//
//  Created by student3 on 5/4/17.
//  Copyright © 2017 John Hersey High School. All rights reserved.
//

import SpriteKit
import GameplayKit


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
    
    override func didMove(to view: SKView)
    {
        rightPaddle = self.childNode(withName: "rightPaddle") as! SKSpriteNode
        leftPaddle = self.childNode(withName: "leftPaddle") as! SKSpriteNode
        puck = self.childNode(withName: "puck") as! SKSpriteNode
        rightGoal = self.childNode(withName: "rightGoal") as! SKSpriteNode
        leftGoal = self.childNode(withName: "leftGoal") as! SKSpriteNode
        leftScore = self.childNode(withName: "leftScore") as! SKLabelNode
        rightScore = self.childNode(withName: "rightScore") as! SKLabelNode
        
        physicsWorld.contactDelegate = self
        
        let bottomLeft = CGPoint(x: frame.origin.x, y: frame.origin.y)
        let bottomRight = CGPoint(x: -frame.origin.x, y: frame.origin.y)
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
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if location.x > 0 && location.y < 249{
                rightPaddle.run(SKAction.move(to: location, duration: 0.1))
            }
            if location.x < 0 && location.y < 249 {
                leftPaddle.run(SKAction.move(to: location, duration: 0.1))
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if location.x > 0 && location.y < 249{
                rightPaddle.run(SKAction.move(to: location, duration: 0.1))
            }
            if location.x < 0 && location.y < 249 {
                leftPaddle.run(SKAction.move(to: location, duration: 0.1))
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == rightGoalCategory {
            print("Here")
            leftScoreCounter += 1
            print(leftScoreCounter)
            leftScore.text = "\(leftScoreCounter)"
        }
        else if contact.bodyA.categoryBitMask == leftGoalCategory {
            rightScoreCounter += 1
            rightScore.text = "\(rightScoreCounter)"
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
