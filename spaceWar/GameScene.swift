//
//  GameScene.swift
//  spaceWar
//
//  Created by Vladislav Dudevich on 22.04.2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var spaceShip: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        view.backgroundColor = .white
        
        spaceShip = SKSpriteNode(imageNamed: "spaceship")
        spaceShip.position = CGPoint(x: 200, y: 200)
        spaceShip.xScale = 1.5
        spaceShip.yScale = 1.5
        spaceShip.physicsBody = SKPhysicsBody(texture: spaceShip.texture!, size: spaceShip.size)
        spaceShip.physicsBody?.isDynamic = false
        addChild(spaceShip)
        
        let asteroidCreate = SKAction.run {
            let asteroid = self.createAsteroid()
            self.addChild(asteroid)
        }
        let asteroidCreationDelay = SKAction.wait(forDuration: 1.0, withRange: 0.5)
        let asteroidSequenceAction = SKAction.sequence([asteroidCreate, asteroidCreationDelay])
        
        let asteroidRunAction = SKAction.repeatForever(asteroidSequenceAction)
        run(asteroidRunAction)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
           let touchLocation = touch.location(in: self)
            print(touchLocation)
            
            let moveAction = SKAction.move(to: touchLocation, duration: 1)
            spaceShip.run(moveAction)
        }
        
    }
}

private extension GameScene {
    
    func createAsteroid() -> SKSpriteNode {
        let asteroid = SKSpriteNode(imageNamed: "asteroid")
        asteroid.position.y = frame.size.height + asteroid.size.height
        asteroid.position.x = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: 16))
        asteroid.physicsBody = SKPhysicsBody(texture: asteroid.texture!, size: asteroid.size)
        return asteroid
    }
    
    func generationAsteroid() {
        
    }
}
