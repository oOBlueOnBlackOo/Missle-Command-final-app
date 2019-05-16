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
    static let none: UInt32 = 0
  //  static let all: UInt32 = UInt32.max
    static let bomb: UInt32 = 2 //#1
    static let projectile: UInt32 = 4
    static let turret: UInt32 = 8
    static let city: UInt32 = 16
    static let cityTwo: UInt32 = 32
}

class GameScene: SKScene {
let city = SKSpriteNode(imageNamed: "city")
let city2 = SKSpriteNode(imageNamed: "city2")
let missile = SKSpriteNode(imageNamed: "missile 1")
let turret = SKSpriteNode(imageNamed: "Turret")
var scoreLabel: SKLabelNode!
    
    
    var score = 0
    var bombsDestroyed = 0
    
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
        city.size.width = 100
        city.size.height = 75
        city.physicsBody = SKPhysicsBody( circleOfRadius: city.size.width/2)
        city.physicsBody?.isDynamic = true
        city.physicsBody?.categoryBitMask = PhysicsCategory.cityTwo
        city.physicsBody?.contactTestBitMask = PhysicsCategory.bomb
        city.physicsBody?.collisionBitMask = PhysicsCategory.none
        city.physicsBody?.usesPreciseCollisionDetection = true
        city.physicsBody?.affectedByGravity = false
       
        addChild(city)
    }
    func city2Spawn()  {
        
        city2.name = "city2"
        city2.position = CGPoint(x: 305, y: 23)
        city2.size.width = 100
        city2.size.height = 75
        city2.physicsBody = SKPhysicsBody( circleOfRadius: city2.size.width/2)
        city2.physicsBody?.isDynamic = true
        city2.physicsBody?.categoryBitMask = PhysicsCategory.cityTwo
        city2.physicsBody?.contactTestBitMask = PhysicsCategory.bomb
        city2.physicsBody?.collisionBitMask = PhysicsCategory.none
        city2.physicsBody?.usesPreciseCollisionDetection = true
        city2.physicsBody?.affectedByGravity = false
      
        addChild(city2)
    }
  
    
    override func didMove(to view: SKView) {
       
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .center
        scoreLabel.position = CGPoint(x: 185, y:625)
        
        addChild(scoreLabel)
        
       turretSpawn()
       citySpawn()
       city2Spawn()
    
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run(createEnemy),SKAction.wait(forDuration: 1.0) ])))
        
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self
      
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
       // bomb.physicsBody = SKPhysicsBody(rectangleOf: bomb.size)
       
       
        bomb.size.width = 50
        bomb.size.height = 50
        bomb.physicsBody = SKPhysicsBody(rectangleOf: bomb.size)
        bomb.physicsBody?.isDynamic = true
        bomb.physicsBody?.categoryBitMask = PhysicsCategory.bomb
        bomb.physicsBody?.contactTestBitMask = PhysicsCategory.projectile
        bomb.physicsBody?.collisionBitMask = PhysicsCategory.none
        bomb.physicsBody?.usesPreciseCollisionDetection = true
        
        // Determine speed of the monster
        let actualDuration = random(min: CGFloat(3.0), max: CGFloat(4.0))
        
        // Create the actions
        
        
    let actionMove = SKAction.move(to: CGPoint(x: actualX, y: -bomb.size.width/2),
            duration: TimeInterval(actualDuration))
    let actionMoveDone = SKAction.removeFromParent()
        
        
        let loseAction = SKAction.run() { [weak self] in
            guard let `self` = self else { return }
            let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
            let gameOverScene = GameOverScene(size: self.size, won: false)
            self.view?.presentScene(gameOverScene, transition: reveal)
        }
        bomb.run(SKAction.sequence([actionMove, loseAction, actionMoveDone]))
        
      
    
    }
   // func randomPoint() -> CGPoint{
   //     var xPos = Int.random(in: 0...Int(self.size.width))
   //     var yPos = Int.random(in: 0...Int(self.size.height))
   //     return CGPoint(x: xPos, y: yPos)
   // }
    


override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    // 1 - Choose one of the touches to work with, gets the location of the last touch
    guard let touch = touches.first else {
        return
    }
    let touchLocation = touch.location(in: self)
    
    // 2 - Set up initial location of projectile
    let projectile = SKSpriteNode(imageNamed: "missile 1")
    projectile.position = turret.position
    
    // 3 - Determine offset of location to projectile
    let offset = touchLocation - projectile.position
    
    
    
    // 5 - OK to add now - you've double checked position
    addChild(projectile)
    
    // 6 - Get the direction of where to shoot
    let direction = offset.normalized()
    
    // 7 - Make it shoot far enough to be guaranteed off screen
    let shootAmount = direction * 1000
    
    // 8 - Add the shoot amount to the current position
    let realDest = shootAmount + projectile.position
    
    // 9 - Create the actions
    let actionMove = SKAction.move(to: realDest, duration: 2.0)
    let actionMoveDone = SKAction.removeFromParent()
    projectile.run(SKAction.sequence([actionMove, actionMoveDone]))
    
    
    projectile.size.height = 50
    projectile.size.width = 50
    
    projectile.physicsBody = SKPhysicsBody( circleOfRadius: projectile.size.width/2)
    projectile.physicsBody?.isDynamic = true
    projectile.physicsBody?.categoryBitMask = PhysicsCategory.projectile
    projectile.physicsBody?.contactTestBitMask = PhysicsCategory.bomb
    projectile.physicsBody?.collisionBitMask = PhysicsCategory.none
    projectile.physicsBody?.usesPreciseCollisionDetection = true
    
    
}
    
    func projectileDidCollideWithMonster(projectile: SKSpriteNode, bomb: SKSpriteNode) {
        print("hit")
        projectile.removeFromParent()
        bomb.removeFromParent()
        
        bombsDestroyed += 1
        if bombsDestroyed > 30 {
            let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
            let gameOverScene = GameOverScene(size: self.size, won: true)
            view?.presentScene(gameOverScene, transition: reveal)
        }
        
    }

    func bombDidCollideWithCity(city: SKSpriteNode, bomb: SKSpriteNode) {
        print("boom")
        city.removeFromParent()
        bomb.removeFromParent()
       
    }
    
    func bombDidCollideWithCity2(city2: SKSpriteNode, bomb: SKSpriteNode) {
        print("bang")
        city2.removeFromParent()
        bomb.removeFromParent()
      
    }
    
    
}

extension GameScene: SKPhysicsContactDelegate {
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        // 1
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        // 2
           //   if ((firstBody.categoryBitMask & PhysicsCategory.bomb != 0) &&
           // (secondBody.categoryBitMask & PhysicsCategory.projectile != 0))
        
        if let bomb = firstBody.node as? SKSpriteNode,
         let projectile = secondBody.node as? SKSpriteNode {
            projectileDidCollideWithMonster(projectile: projectile, bomb: bomb)
            score = score + 100
            scoreLabel.text = "Score \(score)"
            
        }
        
       if let bomb = firstBody.node as? SKSpriteNode,
        let city = secondBody.node as? SKSpriteNode{
        bombDidCollideWithCity(city: city, bomb: bomb)
        
        }
        
       if let bomb = firstBody.node as? SKSpriteNode,
        let city2 = secondBody.node as? SKSpriteNode{
        bombDidCollideWithCity2(city2: city2, bomb: bomb)
     
        }
        
    }
}


