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
    static let bomb: UInt32 = 2 //#1
 //   static let projectile: UInt32 = 4
    //static let player: UInt32 = 1
    
}

class GameScene: SKScene,SKPhysicsContactDelegate {
    
let city = SKSpriteNode(imageNamed: "city")
let city2 = SKSpriteNode(imageNamed: "city2")
let missile = SKSpriteNode(imageNamed: "missile 1")
let turret = SKSpriteNode(imageNamed: "Turret")
    
    func turretSpawn(){
        
        turret.name = "Turret"
        turret.position = CGPoint(x: 175, y: 0)
        turret.physicsBody?.affectedByGravity = false
        turret.size.width = 75
        turret.size.height = 75
        addChild(turret)
    }
    func citySpawn(){
        
        city.name = "city"
        city.position = CGPoint(x: 85, y: 23)
        city.physicsBody?.affectedByGravity = false
        city.size.width = 100
        city.size.height = 75
        addChild(city)
    }
    func city2Spawn()  {
        
        city2.name = "city2"
        city2.position = CGPoint(x: 305, y: 23)
        city2.physicsBody?.affectedByGravity = false
        city2.size.width = 100
        city2.size.height = 75
        addChild(city2)
    }
    override func didMove(to view: SKView){
    
       turretSpawn()
       citySpawn()
       city2Spawn()
    
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
      
        // Create sprite
        let bomb = SKSpriteNode(imageNamed: "missile 2")
        bomb.name = "missile 2"
        
        // Determine where to spawn the monster along the Y axis
        let actualX = random(min: bomb.size.width/5, max: size.width - bomb.size.width/5)
        
        // Position the monster slightly off-screen along the right edge,
        // and along a random position along the Y axis as calculated above
        bomb.position = CGPoint(x: actualX, y: size.width + bomb.size.width)
        
        // Add the monster to the scene
        addChild(bomb)
      //  monster.physicsBody = SKPhysicsBody(rectangleOf: monster.size)
      //  monster.physicsBody?.isDynamic = true
      //  monster.physicsBody?.categoryBitMask = 2
      //  monster.physicsBody?.contactTestBitMask = PhysicsCatagory.projectile
      //  monster.physicsBody?.collisionBitMask = PhysicsCatagory.none
        
        bomb.size.width = 50
        bomb.size.height = 50
        // Determine speed of the monster
        let actualDuration = random(min: CGFloat(3.0), max: CGFloat(4.0))
        
        // Create the actions
        let actionMove = SKAction.move(to: CGPoint(x: actualX, y: -bomb.size.width/2),
                                       duration: TimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        bomb.run(SKAction.sequence([actionMove, actionMoveDone]))
        
    
    
    
    
    }
   // func randomPoint() -> CGPoint{
   //     var xPos = Int.random(in: 0...Int(self.size.width))
   //     var yPos = Int.random(in: 0...Int(self.size.height))
   //     return CGPoint(x: xPos, y: yPos)
   // }
    
}
