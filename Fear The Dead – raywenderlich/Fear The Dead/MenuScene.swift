//
//  MenuScene.swift
//  Fear The Dead
//
//  Created by Morten Faarkrog on 12/09/15.
//  Copyright © 2015 Razeware. All rights reserved.
//

import UIKit
import SpriteKit

class MenuScene: SKScene {

  var soundToPlay: String?
  
    override func didMove(to view: SKView) {
    self.backgroundColor = SKColor(red: 0, green:0, blue:0, alpha: 1)
    
    // Setup label
    let label = SKLabelNode(text: "Press anywhere to play again!")
    label.fontName = "AvenirNext-Bold"
    label.fontSize = 55
        label.fontColor = UIColor.white
        label.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
    
    // Play sound
    if let soundToPlay = soundToPlay {
        self.run(SKAction.playSoundFileNamed(soundToPlay, waitForCompletion: false))
    }
    
    self.addChild(label)
  }
  
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    let gameScene = GameScene(fileNamed: "GameScene")
        let transition = SKTransition.flipVertical(withDuration: 1.0)
    let skView = self.view as SKView!
        gameScene?.scaleMode = .aspectFill
        skView?.presentScene(gameScene!, transition: transition)
  }
  
}
