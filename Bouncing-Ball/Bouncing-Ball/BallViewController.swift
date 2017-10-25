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
        
        let obstacleFrame = CGRect(x: 0, y: 300, width: 130, height: 20)
        let barrier = UIView(frame: obstacleFrame)
        ballBehavior.addObstacle(for: UIBezierPath(rect: obstacleFrame))
        barrier.backgroundColor = UIColor.red
        view.addSubview(barrier)
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
            
//            ballCoordinates = ball.
            
            translationCoordinate = panGesture.translation(in: view)
            ballCoordinates.x += translationCoordinate!.x
            ballCoordinates.y += translationCoordinate!.y
            
            sumOfTranslation.x += translationCoordinate!.x
            sumOfTranslation.y += translationCoordinate!.y

            panGesture.setTranslation(CGPoint.zero, in: view)
            updateUI()
            someBallAction()

            
        case  .ended:
            animator.addBehavior(ballBehavior)
            translationCoordinate = panGesture.translation(in: view)

            if panGesture.velocity(in: view).x > 0.0 || panGesture.velocity(in: view).y > 0.0 {
                ballBehavior.startPushing(by: 0.1, to: CGVector(dx: sumOfTranslation.x, dy: sumOfTranslation.y))
            }

            
            
            panGesture.setTranslation(CGPoint.zero, in: view)
            updateUI()
            sumOfTranslation = CGPoint.zero
            
        default:
            break
        }
    }

    private var sumOfTranslation = CGPoint.zero
    private var translationCoordinate: CGPoint?
    private lazy var animator: UIDynamicAnimator = UIDynamicAnimator(referenceView: self.view)
    private var ballBehavior = BallBehavior()
    
    let ball = BallView()
    private lazy var ballCoordinates: CGPoint = CGPoint.init(x: view.bounds.midX - ballSize.width/2, y: view.bounds.midY - ballSize.height/2)
    private let ballSize = CGSize(width: 70.0, height: 70.0)
    
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
        updateUI()
    }
    
    private func updateUI() {
        ball.frame = CGRect(origin: ballCoordinates, size: ballSize)
        ball.backgroundColor = UIColor.clear
        view.addSubview(ball)
    }
    
    private var updateCount = 0
    
    func someBallAction() {
        if (updateCount % 3 == 0) {
            
            let outline = BallView(frame: ball.bounds)
            outline.color = UIColor.darkGray
            outline.transform = ball.transform
            
            outline.linewidth = 3.0
            outline.center = ball.center
            outline.alpha = 0.5
            outline.backgroundColor = UIColor.clear
        
            view.addSubview(outline)
            
            UIView.animate(withDuration: 0.3, delay: 0.7, options: .curveEaseOut,
                           animations: {outline.transform = CGAffineTransform.init(translationX: 1.0, y: 5.0)},
                           completion: {finished in outline.removeFromSuperview()}
            )
        }
        updateCount += 1
    }

}
