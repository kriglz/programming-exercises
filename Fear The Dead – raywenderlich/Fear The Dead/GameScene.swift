//
//  GameScene.swift
//  Fear The Dead
//
//  Created by Morten Faarkrog on 08/09/15.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // MARK: - Instance Variables
    
    let playerSpeed: CGFloat = 150.0
    let zombieSpeed: CGFloat = 75.0
    
    var goal: SKSpriteNode?
    var player: SKSpriteNode?
    var zombies: [SKSpriteNode] = []
    
    var lastTouch: CGPoint? = nil
    
    
    // MARK: - SKScene
    
    override func didMove(to view: SKView) {
        // Setup physics world's contact delegate
        physicsWorld.contactDelegate = self
        
        //Setup player
        player = self.childNode(withName: "player") as? SKSpriteNode
        
        
        self.listener = player

        //Setup zombies
        for child in self.children {
            if child.name == "zombie" {
                if let child = child as? SKSpriteNode {
                    
                    //AddSKAUDioNode to zombie
                    let audioNode: SKAudioNode = SKAudioNode(fileNamed: "fear_moan.wav")
                    
                    child.addChild(audioNode)
                    
                    zombies.append(child)
                }
            }
        }
        
        //Setup goal
        goal = self.childNode(withName: "goal") as? SKSpriteNode
        
        // Setup initial camera position
        updateCamera()
        
    }
    
    
    // MARK: Touch Handling
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches(touches: touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches(touches: touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches(touches: touches)
    }
    
    private func handleTouches(touches: Set<UITouch>) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            lastTouch = touchLocation
        }
    }
    
    
    // MARK - Updates
    
    override func didSimulatePhysics() {
        if let _ = player {
            updatePlayer()
            updateZombies()
        }
    }
    
    // Determines if the player's position should be updated
    private func shouldMove(currentPosition: CGPoint, touchPosition: CGPoint) -> Bool {
        return abs(currentPosition.x - touchPosition.x) > player!.frame.width / 2 ||
            abs(currentPosition.y - touchPosition.y) > player!.frame.height/2
    }
    
    // Updates the player's position by moving towards the last touch made
    func updatePlayer() {
        if let touch = lastTouch {
            let currentPosition = player!.position
            if shouldMove(currentPosition: currentPosition, touchPosition: touch) {
                
                let angle = atan2(currentPosition.y - touch.y, currentPosition.x - touch.x) + CGFloat(Double.pi)
                let rotateAction = SKAction.rotate(toAngle: angle + CGFloat(Double.pi*0.5), duration: 0)
                
                player!.run(rotateAction)
                
                let velocotyX = playerSpeed * cos(angle)
                let velocityY = playerSpeed * sin(angle)
                
                let newVelocity = CGVector(dx: velocotyX, dy: velocityY)
                player!.physicsBody!.velocity = newVelocity;
                updateCamera()
            } else {
                player!.physicsBody!.isResting = true
            }
        }
    }
    
    func updateCamera() {
        if let camera = camera {
            camera.position = CGPoint(x: player!.position.x, y: player!.position.y)
        }
    }
    
    // Updates the position of all zombies by moving towards the player
    func updateZombies() {
        let targetPosition = player!.position
        
        for zombie in zombies {
            let currentPosition = zombie.position
            
            let angle = atan2(currentPosition.y - targetPosition.y, currentPosition.x - targetPosition.x) + CGFloat(Double.pi)
            let rotateAction = SKAction.rotate(toAngle: angle + CGFloat(Double.pi*0.5), duration: 0.0)
            zombie.run(rotateAction)
            
            let velocotyX = zombieSpeed * cos(angle)
            let velocityY = zombieSpeed * sin(angle)
            
            let newVelocity = CGVector(dx: velocotyX, dy: velocityY)
            zombie.physicsBody!.velocity = newVelocity;
        }
    }
    
    
    // MARK: - SKPhysicsContactDelegate
    
    func didBeginContact(contact: SKPhysicsContact) {
        // 1. Create local variables for two physics bodies
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        // 2. Assign the two physics bodies so that the one with the lower category is always stored in firstBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // 3. react to the contact between the two nodes
        if firstBody.categoryBitMask == player?.physicsBody?.categoryBitMask &&
            secondBody.categoryBitMask == zombies[0].physicsBody?.categoryBitMask {
            // Player & Zombie
            gameOver(didWin: false)
        } else if firstBody.categoryBitMask == player?.physicsBody?.categoryBitMask &&
            secondBody.categoryBitMask == goal?.physicsBody?.categoryBitMask {
            // Player & Goal
            gameOver(didWin: true)
        }
    }
    
    
    // MARK: Helper Functions
    
    private func gameOver(didWin: Bool) {
        print("- - - Game Ended - - -")
        let menuScene = MenuScene(size: self.size)
        menuScene.soundToPlay = didWin ? "fear_win.mp3" : "fear_lose.mp3"
        let transition = SKTransition.flipVertical(withDuration: 1.0)
        menuScene.scaleMode = SKSceneScaleMode.aspectFill
        self.scene!.view?.presentScene(menuScene, transition: transition)
    }
    
}
