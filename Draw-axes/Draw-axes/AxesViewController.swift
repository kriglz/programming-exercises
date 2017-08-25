//
//  ViewController.swift
//  Draw-axes
//
//  Created by Kristina Gelzinyte on 8/23/17.
//  Copyright © 2017 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class AxesViewController: UIView {

    override func draw(_ rect: CGRect) {
        let axes: AxesDrawer =  AxesDrawer.init(color: UIColor.blue, contentScaleFactor: CGFloat(1))
        
        //top right
        axes.drawAxes(in: CGRect(origin: CGPoint(x: bounds.midX, y: bounds.midY),
                                 size: CGSize(width: bounds.midX, height: -bounds.midY)),
                      origin: CGPoint(x: bounds.midX, y: bounds.midY),
                      pointsPerUnit: CGFloat(2))
        
        //bottom right
        axes.drawAxes(in: CGRect(origin: CGPoint(x: bounds.midX, y: bounds.midY),
                                 size: CGSize(width: bounds.midX, height: bounds.midY)),
                      origin: CGPoint(x: bounds.midX, y: bounds.midY),
                      pointsPerUnit: CGFloat(2))
        
        //top left
        axes.drawAxes(in: CGRect(origin: CGPoint(x: bounds.midX, y: bounds.midY),
                                 size: CGSize(width: -bounds.midX, height: -bounds.midY)),
                      origin: CGPoint(x: bounds.midX, y: bounds.midY),
                      pointsPerUnit: CGFloat(2))

        //botton left
        axes.drawAxes(in: CGRect(origin: CGPoint(x: bounds.midX, y: bounds.midY),
                                 size: CGSize(width: -bounds.midX, height: bounds.midY)),
                      origin: CGPoint(x: bounds.midX, y: bounds.midY),
                      pointsPerUnit: CGFloat(2))
        
        
        let sine: AxesDrawer = AxesDrawer.init(color: UIColor.red, contentScaleFactor: CGFloat(1))
        
        sine.drawGraph(in: CGRect(origin: CGPoint(x: bounds.midX, y: bounds.midY),
                                  size: CGSize(width: -2*bounds.midX, height: -2*bounds.midY)),
                       origin: CGPoint(x: bounds.midX, y: bounds.midY),
                       pointsPerUnit: CGFloat(2))
        
    }

}




