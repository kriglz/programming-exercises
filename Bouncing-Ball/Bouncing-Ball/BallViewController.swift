//
//  BallViewController.swift
//  Bouncing-Ball
//
//  Created by Kristina Gelzinyte on 10/23/17.
//  Copyright © 2017 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class BallViewController: UIViewController {

    @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {
        moveTheBall(sender)
    }
    
    private func moveTheBall(_ panGesture: UIPanGestureRecognizer) {
        switch panGesture.state {
        case .changed, .ended:
            translationCoordinate = panGesture.translation(in: view)
//            ballCoordinates?.x += (translationCoordinate?.x)!
//            ballCoordinates?.y += (translationCoordinate?.y)!
            
//            panGesture.velocity(in: view)
            
            ballBehavior.startPushing(to: CGVector(dx: (translationCoordinate?.x)!, dy: (translationCoordinate?.y)!))
            
            ball.setNeedsDisplay()

            
            panGesture.setTranslation(CGPoint.zero, in: view)
            updateUI()
        default:
            break
        }
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        if sender.numberOfTapsRequired == 2 {
            ballCoordinates = CGPoint.init(x: view.bounds.midX - ballSize.width/2, y: view.bounds.midY - ballSize.height/2)
            updateUI()
        }
    }
    
    private var translationCoordinate: CGPoint?
    private lazy var animator: UIDynamicAnimator = UIDynamicAnimator()
    private var ballBehavior = BallBehavior()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animator.addBehavior(ballBehavior)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        animator.removeBehavior(ballBehavior)
    }

    private var ballCoordinates: CGPoint? { didSet{ updateUI()}}
    private let ballSize = CGSize(width: 100.0, height: 100.0)
    let ball = BallView()
    
    private func updateUI() {
        ball.frame = CGRect(origin: ballCoordinates!, size: ballSize)
        ball.backgroundColor = UIColor.clear
    }
    
    
    

    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        ballCoordinates = CGPoint.init(x: view.bounds.midX - ballSize.width/2, y: view.bounds.midY - ballSize.height/2)
        updateUI()
        view.addSubview(ball)
    }
    
}
