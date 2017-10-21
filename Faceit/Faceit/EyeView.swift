//
//  EyeView.swift
//  Faceit
//
//  Created by Kristina Gelzinyte on 10/21/17.
//  Copyright © 2017 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class EyeView: UIView {

    var linewidth: CGFloat = 5.0 { didSet{ setNeedsLayout()}}
    var color: UIColor = UIColor.blue { didSet{ setNeedsDisplay()}}
    
    var _eyesOpen: Bool = true { didSet{ setNeedsDisplay()}}
    
    var eyesOpen: Bool {
        get {
            return _eyesOpen
        } set {
            if newValue != _eyesOpen {
                UIView.transition(
                    with: self,
                    duration: 0.4,
                    options: [.transitionFlipFromTop],
                    animations: {
                        self._eyesOpen = newValue
                })
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        var path: UIBezierPath
        
        if eyesOpen {
            path = UIBezierPath(ovalIn: bounds.insetBy(dx: linewidth/2, dy: linewidth/2))
        } else {
            path = UIBezierPath()
            path.move(to: CGPoint(x: bounds.minX, y: bounds.midY))
            path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.midY))
        }
        
        path.lineWidth = linewidth
        color.setStroke()
        path.stroke()
    }

}
