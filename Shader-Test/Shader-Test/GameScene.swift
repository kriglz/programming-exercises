//
//  GameScene.swift
//  Shader-Test
//
//  Created by Kristina Gelzinyte on 1/3/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
//    override func didMove(to view: SKView) {
//        
//       
//    }
    
    override func sceneDidLoad() {
        let testNode = SKSpriteNode.init(color: .blue, size: CGSize(width: self.size.width / 2, height: self.size.height / 2))
        testNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        testNode.zPosition = 100
        
        // Adds shader which makes water grass to wave.
        let colorShader = SKShader(fileNamed: "ColorShader.fsh")
        colorShader.attributes = [
            SKAttribute(name: "a_sprite_size", type: .vectorFloat2)
        ]
        testNode.shader = colorShader
        let testNodeSize = vector_float2(Float(testNode.size.width),
                                         Float(testNode.size.height))
        testNode.setValue(SKAttributeValue(vectorFloat2: testNodeSize),
                          forAttribute: "a_sprite_size")

        addChild(testNode)
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
