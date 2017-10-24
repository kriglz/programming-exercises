//
//  BallBehavior.swift
//  Bouncing-Ball
//
//  Created by Kristina Gelzinyte on 10/23/17.
//  Copyright © 2017 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class BallBehavior: UIDynamicBehavior, UICollisionBehaviorDelegate {
    private lazy var collider: UICollisionBehavior = {
        let behaviour = UICollisionBehavior()
        behaviour.collisionMode = .boundaries
        behaviour.translatesReferenceBoundsIntoBoundary = true
        behaviour.collisionDelegate = self
        return behaviour
    }()
    
    
    var balls = [BallView]()
    
    func startPushing(by magnitude: CGFloat, to direction: CGVector) {
    
        for ball in balls {
            let pusher = UIPushBehavior(items: [ball], mode: .instantaneous)
            pusher.magnitude = magnitude
            pusher.pushDirection = direction
            addChildBehavior(pusher)
        }
    }
    
    override init() {
        super.init()
        addChildBehavior(collider)
    }
    
    func addBall (_ ball: BallView) {
        collider.addItem(ball)
    }
    
    func removeBall (_ ball: BallView){
        collider.removeItem(ball)
    }
}
