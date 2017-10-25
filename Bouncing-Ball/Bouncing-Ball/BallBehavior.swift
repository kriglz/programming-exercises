//
//  BallBehavior.swift
//  Bouncing-Ball
//
//  Created by Kristina Gelzinyte on 10/23/17.
//  Copyright © 2017 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class BallBehavior: UIDynamicBehavior, UICollisionBehaviorDelegate, UIDynamicAnimatorDelegate {
    private lazy var collider: UICollisionBehavior = {
        let behaviour = UICollisionBehavior()
        behaviour.collisionMode = .boundaries
        behaviour.translatesReferenceBoundsIntoBoundary = true
        behaviour.collisionDelegate = self
        return behaviour
    }()
    
    func addObstacle(for object: UIBezierPath) {
        collider.addBoundary(withIdentifier: "barrier" as NSCopying, for: object)
    }
    
    
    
    
    var balls = [BallView]()
    
    func startPushing(by magnitude: CGFloat, to direction: CGVector) {
        for ball in balls {
            let pusher = UIPushBehavior(items: [ball], mode: .instantaneous)
            pusher.magnitude = magnitude
            pusher.pushDirection = direction
            addChildBehavior(pusher)
        }
    }
    
    private lazy var physics: UIDynamicItemBehavior = {
        let behavior = UIDynamicItemBehavior(items: balls)
        behavior.elasticity = 0.5
        behavior.allowsRotation = false
        behavior.friction = 0.5
        return behavior
    }()
    
    override init() {
        super.init()
        addChildBehavior(collider)
        addChildBehavior(physics)
    }
    
    func addBall (_ ball: BallView) {
        collider.addItem(ball)
        physics.addItem(ball)
    }
    
    func removeBall (_ ball: BallView){
        collider.removeItem(ball)
        physics.removeItem(ball)
    }
}
