//
//  GameViewController2.swift
//  AirHockey2
//
//  Created by student1 on 5/5/17.
//  Copyright © 2017 John Hersey High School. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController2: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView?
        {
            // Load the SKScene from 'GameScene.sks'
            
        if let scene = SKScene(fileNamed: "onePlayer")
        {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
                
            // Present the scene
            view.presentScene(scene)
        }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            if UIDevice.current.userInterfaceIdiom == .phone
            {
                return .allButUpsideDown
            }
            
            else {
                    return .all
                 }
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

