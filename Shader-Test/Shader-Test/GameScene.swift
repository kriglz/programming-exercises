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
    
    let shaders = ["PerlinsNoise.fsh",
                   "ConnectingLines.fsh",
                   "RandomDrops.fsh",
                   "CubicPulse2.fsh",
                   "CubicPulse.fsh",
                   "NoiseFromTriangles.fsh",
                   "NoisyShapeShader.fsh",
                   "NoisePattern.fsh",
                   "WoodPattern.fsh",
                   "2DNoiseShader.fsh",
                   "NoiceShader.fsh",
                   "RandomMovingRows3.fsh",
                   "RandomMovingRows2.fsh",
                   "RandomMovingRows.fsh",
                   "RandomPatternShader.fsh",
                   "RandomShader.fsh",
                   "TilePatternShader.fsh",
                   "TruchetTiles.fsh",
                   "BrickWall.fsh",
                   "MatrixPattern.fsh",
                   "ColorGrid.fsh",
                   "RGBColorTransformYUV.fsh",
                   "OblivionRadar.fsh",
                   "MovingPlus.fsh",
                   "DistanceCombinedShader.fsh",
                   "PolarShader.fsh",
                   "DistanceFieldShader.fsh",
                   "CircleShader.fsh",
                   "CircularShader.fsh",
                   "ShapeShader.fsh",
                   "SpectrumShader.fsh",
                   "ColorMoveShader.fsh",
                   "ColorMixShader.fsh",
                   "CircularShapeShader.fsh",
                   "TestShader.fsh",
                   "ColorShader.fsh",
                   "InterferanceShader.fsh",
                   "ShapeGradientShader.fsh"]
    
    private lazy var currentShader: SKShader = SKShader(fileNamed: shaders[0])
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
        
        addTheShader()
        
        addChild(testNode)
    }
    
    
    @objc private func handleTapGesture(byReactingTo: UITapGestureRecognizer){
//        if shaderIndex != shaders.count-1 {
//            shaderIndex += 1
//        } else {
//            shaderIndex = 0
//        }
//        addTheShader()
        print(tapPosition)
        tapPosition = byReactingTo.location(in: self.view)
        addTheShader()
    }
    
    var tapPosition = CGPoint.zero
    
    private func addTheShader(){
        currentShader = SKShader(fileNamed: shaders[shaderIndex])
        testNode.shader = currentShader
        
        // Adds the shader to the node.
        currentShader.attributes = [
            SKAttribute(name: "a_sprite_size", type: .vectorFloat2),
            SKAttribute(name: "a_mouse", type: .vectorFloat2)
        ]
        testNode.shader = currentShader
        let testNodeSize = vector_float2(Float(testNode.size.width*UIScreen.main.scale),
                                         Float(testNode.size.height*UIScreen.main.scale))
        testNode.setValue(SKAttributeValue(vectorFloat2: testNodeSize),
                          forAttribute: "a_sprite_size")
        
        let mousePosition = vector_float2(Float(tapPosition.x),
                                         Float(tapPosition.y))
        testNode.setValue(SKAttributeValue(vectorFloat2: mousePosition),
                          forAttribute: "a_mouse")
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
