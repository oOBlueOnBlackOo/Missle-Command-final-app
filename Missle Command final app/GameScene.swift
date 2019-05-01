//
//  GameScene.swift
//  Missle Command final app
//
//  Created by OWEN MILLER on 4/17/19.
//  Copyright © 2019 CLC.Miller. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    
    
    
    
    
    
    
    
    
    
    override func didMove(to view: SKView) {
    
        
        
        
        
        
        
        
      
        }
        
    
    
    func addBalloon() {
        
        // Create sprite
        let monster = SKSpriteNode(imageNamed: "")
        monster.name = ""
        
        // Determine where to spawn the monster along the Y axis
        let actualY = random(min: monster.size.height/3, max: size.height - monster.size.height/3)
        
        // Position the monster slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        monster.position = CGPoint(x: actualY, y: size.width + monster.size.width/2)
        
        // Add the monster to the scene
        addChild(monster)
        monster.size.width = 150
        monster.size.height = 150
        // Determine speed of the monster
        let actualDuration = random(min: CGFloat(0.0), max: CGFloat(3.0))
        
        // Create the actions
        let actionMove = SKAction.move(to: CGPoint(x: actualY, y: -monster.size.width/1),
                                       duration: TimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        monster.run(SKAction.sequence([actionMove, actionMoveDone]))
        
        
        
    }

    
    
    
    
    
    
    
    
}
