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
//        behaviour.collisionMode = .boundaries
        behaviour.translatesReferenceBoundsIntoBoundary = true
        behaviour.collisionDelegate = self
        return behaviour
    }()
    
    private lazy var pusher: UIPushBehavior = {
        let behavior = UIPushBehavior()
        behavior.magnitude = 1.0
        behavior.angle = CGFloat.pi
//        behavior.pushDirection = CGVector(dx: <#T##CGFloat#>, dy: <#T##CGFloat#>)
        return behavior
    }()
    
    private var balls = [BallView]()

    func startPushing(by magnitude: Range<CGFloat> = 0.1..<0.5, to direction: CGVector) {
        for ball in balls {
            let pusher = UIPushBehavior(items: [ball], mode: .continuous)
            pusher.magnitude = 0.4
//            pusher.angle = CGFloat.pi*2
            pusher.pushDirection = direction
            addChildBehavior(pusher)
        }
    }
    
    override init() {
        super.init()
        addChildBehavior(collider)
        addChildBehavior(pusher)
    }
    
    func addBall (_ ball: BallView) {
        collider.addItem(ball)
    }
    
    func removeBall (_ ball: BallView){
        collider.removeItem(ball)
    }
}
