//
//  GameScene.swift
//  Missle Command final app
//
//  Created by OWEN MILLER on 4/17/19.
//  Copyright © 2019 CLC.Miller. All rights reserved.
//

import SpriteKit
import GameplayKit
struct PhysicsCategory {
 //   static let none: UInt32 = 0
  //  static let all: UInt32 = UInt32.max
    static let enemy: UInt32 = 2 //#1
 //   static let projectile: UInt32 = 4
    //static let player: UInt32 = 1
    
}

class GameScene: SKScene,SKPhysicsContactDelegate {
let city = SKSpriteNode(imageNamed: "city")
//city.name = "city"
let missile = SKSpriteNode(imageNamed: "missile 1")
//missile.name = "missile 1"
let turret = SKSpriteNode(imageNamed: "Turret")
    
    
    func turretSpawn(){
        turret.name = "Turret"
        turret.position = CGPoint(x: 0, y: -620)
        turret.physicsBody?.affectedByGravity = false
        turret.size.width = 100
        turret.size.height = 100
        addChild(turret)
    }
    
    
    
    override func didMove(to view: SKView) {
       turretSpawn()
   
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(createEnemy),
                SKAction.wait(forDuration: 1.0)
                
                
                
                ])
        ))
        
        
        
        
        
      
        }
    
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
        
    
    
    func createEnemy() {
        var enemy = SKSpriteNode(imageNamed: "missile 2")
        enemy.scale(to: CGSize(width: 100, height: 100))
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        enemy.position = CGPoint(x: self.size.width, y: 300)
        enemy.physicsBody?.categoryBitMask = PhysicsCategory.enemy
     //   enemy.physicsBody?.contactTestBitMask = PhysicsCategory.projectile
        //enemy.physicsBody?.collisionBitMask = PhysicsCategory.none
        addChild(enemy)
        let actionMove = SKAction.move(to: CGPoint(x: 0, y: 300), duration: TimeInterval(CGFloat.random(in: 2.0...4.0)))
        let actionMoveDone = SKAction.removeFromParent()
        enemy.run(SKAction.sequence([actionMove,actionMoveDone]))
    }
    func randomPoint() -> CGPoint{
        var xPos = Int.random(in: 0...Int(self.size.width))
        var yPos = Int.random(in: 0...Int(self.size.height))
        return CGPoint(x: xPos, y: yPos)
    }
    
}
