//
//  BallView.swift
//  Bouncing-Ball
//
//  Created by Kristina Gelzinyte on 10/23/17.
//  Copyright © 2017 Kristina Gelzinyte. All rights reserved.
//

import UIKit

@IBDesignable
class BallView: UIView {
    
    var linewidth: CGFloat = 5.0 { didSet{ setNeedsLayout()}}
    var color: UIColor = UIColor.blue { didSet{ setNeedsDisplay()}}
    
    override func draw(_ rect: CGRect) {
        var path = UIBezierPath()
        path = UIBezierPath(ovalIn: bounds.insetBy(dx: linewidth/2, dy: linewidth/2))
        path.lineWidth = linewidth
        color.setStroke()
        path.stroke()
    }
    

}
