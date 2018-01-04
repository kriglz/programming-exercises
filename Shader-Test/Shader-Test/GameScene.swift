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
    
    let shaders = ["TestShader.fsh",
                   "ColorShader.fsh",
                   "InterferanceShader.fsh",
                   "CircularShapeShader.fsh",
                   "ShapeGradientShader.fsh"]
    
    private lazy var currentSader: SKShader = SKShader(fileNamed: shaders[0])
    private var shaderIndex: Int = 0
    private var testNode: SKSpriteNode!

    override func didMove(to view: SKView) {
        // Adds tap handler to the scene.
        let tapHandler = #selector(handleTapGesture(byReactingTo:))
        let tapRecognizer = UITapGestureRecognizer(target: self, action: tapHandler)
        tapRecognizer.numberOfTapsRequired = 1
        self.view?.addGestureRecognizer(tapRecognizer)
    }
    
    override func sceneDidLoad() {
        
        testNode = SKSpriteNode.init(color: .blue, size: CGSize(width: self.size.width, height: self.size.height))
        testNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        testNode.zPosition = 100
        
        // Adds the shader to the node.
        currentSader.attributes = [
            SKAttribute(name: "a_sprite_size", type: .vectorFloat2)
        ]
        testNode.shader = currentSader
        let testNodeSize = vector_float2(Float(testNode.size.width),
                                         Float(testNode.size.height))
        testNode.setValue(SKAttributeValue(vectorFloat2: testNodeSize),
                          forAttribute: "a_sprite_size")

        addChild(testNode)
    }
    
    
    @objc private func handleTapGesture(byReactingTo: UITapGestureRecognizer){
        if shaderIndex != shaders.count-1 {
            shaderIndex += 1
        } else {
            shaderIndex = 0
        }
        currentSader = SKShader(fileNamed: shaders[shaderIndex])
        testNode.shader = currentSader
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
