//
//  GameViewController.swift
//  Shader-Test
//
//  Created by Kristina Gelzinyte on 1/3/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    @IBOutlet weak var shaderLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Loading scene directly.
        /// Main game scene.
        let gameWorldSize = CGSize.init(width: view.frame.size.width, height: view.frame.size.height)
        let gameScene = GameScene(size: gameWorldSize)
        gameScene.sceneShaderDelegate = self
        
        // Present the scene
        if let view = self.view as! SKView? {
            view.presentScene(gameScene)
            view.ignoresSiblingOrder = true
//            view.showsPhysics = true
//            view.showsFPS = true
//            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension GameViewController: GameSceneDelegate {
    func gameScene(_ gameScene: GameScene, didChangeShader title: String) {
        shaderLabel.text = title
    }
}
