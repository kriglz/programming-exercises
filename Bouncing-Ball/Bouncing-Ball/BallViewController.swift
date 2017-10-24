//
//  BallViewController.swift
//  Bouncing-Ball
//
//  Created by Kristina Gelzinyte on 10/23/17.
//  Copyright © 2017 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class BallViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let singleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapAction(byReactingTo:)))
        singleTapRecognizer.numberOfTapsRequired = 1
        view.addGestureRecognizer(singleTapRecognizer)
        
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTapAction(byReactingTo:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTapRecognizer)
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(moveTheBall(byReactingTo:)))
        view.addGestureRecognizer(panRecognizer)
    }

    
    
    @objc private func doubleTapAction(byReactingTo tapRecognizer: UITapGestureRecognizer){
        if tapRecognizer.numberOfTapsRequired == 2 {
            animator.removeBehavior(ballBehavior)
            ballCoordinates = CGPoint.init(x: view.bounds.midX - ballSize.width/2, y: view.bounds.midY - ballSize.height/2)
            updateUI()
        }
    }
        
    @objc private func tapAction(byReactingTo tapRecognizer: UITapGestureRecognizer){
        if tapRecognizer.numberOfTapsRequired == 1 {
            animator.removeBehavior(ballBehavior)
        }
    }
    
    @objc private func moveTheBall(byReactingTo panGesture: UIPanGestureRecognizer) {
        switch panGesture.state {
        case .began, .changed:
            translationCoordinate = panGesture.translation(in: self.view)
            ballCoordinates!.x += translationCoordinate!.x
            ballCoordinates!.y += translationCoordinate!.y
            
            print("original", ballCoordinates)
            
            updateUI()
//            print(ball.center)

            
            panGesture.setTranslation(CGPoint.zero, in: view)
            
        case  .ended:
            print("ended")
            
//            animator.addBehavior(ballBehavior)
//
//            translationCoordinate = panGesture.translation(in: view)
//            ballCoordinates?.x += (translationCoordinate?.x)!
//            ballCoordinates?.y += (translationCoordinate?.y)!
//
//
//            ballBehavior.startPushing(by: 0.1, to: CGVector(dx: (translationCoordinate?.x)!, dy: (translationCoordinate?.y)!))
//
//            updateUI()
            panGesture.setTranslation(CGPoint.zero, in: view)
            
            
            
        default:
            break
        }
    }

    
    private var translationCoordinate: CGPoint?
    private lazy var animator: UIDynamicAnimator = UIDynamicAnimator(referenceView: self.view)
    private var ballBehavior = BallBehavior()
    private var ballCoordinates: CGPoint? //{ didSet{ updateUI()}}
    private let ballSize = CGSize(width: 100.0, height: 100.0)
    let ball = BallView()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ballBehavior.balls.append(ball)
        ballBehavior.removeBall(ball)
        ballBehavior.addBall(ball)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        animator.removeBehavior(ballBehavior)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        ballCoordinates = CGPoint.init(x: view.bounds.midX - ballSize.width/2, y: view.bounds.midY - ballSize.height/2)
        updateUI()
    }
    
    private func updateUI() {
//        ball.center = ballCoordinates!
//        ball.frame.size = ballSize
        ball.frame = CGRect(origin: ballCoordinates!, size: ballSize)
        
        ball.backgroundColor = UIColor.clear
        ball.setNeedsDisplay()

        
        view.addSubview(ball)
    }
}
