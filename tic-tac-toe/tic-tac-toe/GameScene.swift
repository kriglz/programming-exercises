//
//  GameScene.swift
//  tic-tac-toe
//
//  Created by Kristina Gelzinyte on 11/6/17.
//  Copyright © 2017 Kristina Gelzinyte. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var gameBoard: Board!
    var stateMachine: GKStateMachine!
    var ai: GKMinmaxStrategist!
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        
        let top_left: BoardCell  = BoardCell(value: .none, node: "top_left")
        let top_middle: BoardCell = BoardCell(value: .none, node: "top_middle")
        let top_right: BoardCell = BoardCell(value: .none, node: "top_right")
        let middle_left: BoardCell = BoardCell(value: .none, node: "middle_left")
        let center: BoardCell = BoardCell(value: .none, node: "center")
        let middle_right: BoardCell = BoardCell(value: .none, node: "middle_right")
        let bottom_left: BoardCell = BoardCell(value: .none, node: "bottom_left")
        let bottom_middle: BoardCell = BoardCell(value: .none, node: "bottom_middle")
        let bottom_right: BoardCell = BoardCell(value: .none, node: "bottom_right")
        
        let board = [top_left, top_middle, top_right, middle_left, center, middle_right, bottom_left, bottom_middle, bottom_right]
        
        
        gameBoard = Board(gameboard: board)
        
        
        
        ai = GKMinmaxStrategist()
        ai.maxLookAheadDepth = 9
        ai.randomSource = GKARC4RandomSource()
        
        let beginGameState = StartGameState(scene: self)
        let activeGameState = ActiveGameState(scene: self)
        let endGameState = EndGameState(scene: self)
        
        stateMachine = GKStateMachine(states: [beginGameState, activeGameState, endGameState])
        stateMachine.enter(StartGameState.self)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {        
        for touch in touches {
            let location = touch.location(in: self)
            let selectedNode = self.atPoint(location)
            var node: SKSpriteNode
            
            
            if let name = selectedNode.name {
                if name == "Reset" || name == "reset_label"{
                    self.stateMachine.enter(StartGameState.self)
                    return
                }
            }
            
            if gameBoard.isPlayerOne(){
                let cross = SKSpriteNode(imageNamed: "X_symbol")
                cross.size = CGSize(width: 75, height: 75)
                cross.zRotation = CGFloat(.pi / 4.0)
                node = cross
                node.name = "cross"
            } else {
                let circle = SKSpriteNode(imageNamed: "O_symbol")
                circle.size = CGSize(width: 75, height: 75)
                node = circle
                node.name = "circle"
            }
            
            
            if selectedNode.parent?.name == "grid" {
                for i in 0...8 {

                    let cellNode = selectedNode.parent?.childNode(withName: gameBoard.getElementAtBoardLocation(i).node)
                    
                    if selectedNode.name == cellNode?.name {
                        cellNode?.addChild(node)
                        gameBoard.addPlayerValueAtBoardLocation(i, value: (gameBoard.isPlayerOne() ? .x : .o))
                        gameBoard.togglePlayer()
                    }
                }
            }
        }       
    }
    
    
    override func update(_ currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        self.stateMachine.update(deltaTime: currentTime)
    }
}
