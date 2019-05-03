//
//  GameViewController.swift
//  Missle Command final app
//
//  Created by OWEN MILLER on 4/17/19.
//  Copyright © 2019 CLC.Miller. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("view load")
        
        // creating a game scene with the size of the view controller
        let scene = GameScene(size: view.bounds.size)
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        
        // converting the view controller to a sprite Kit View
        
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .resizeFill
        
        // Present the scene
        skView.presentScene(scene)
        
        
        skView.ignoresSiblingOrder = true
        
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        }
    


}
