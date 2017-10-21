//
//  FaceView.swift
//  Faceit
//
//  Created by Kristina Gelzinyte on 7/19/17.
//  Copyright © 2017 Kristina Gelzinyte. All rights reserved.
//

import UIKit

@IBDesignable
class FaceView: UIView
{
    //Public API
    
    @IBInspectable
    var scale: CGFloat = 0.9 { didSet {
        setNeedsDisplay()}}
    
    @IBInspectable
    var eyesOpen: Bool = true { didSet {
        leftEye.eyesOpen = eyesOpen
        rightEye.eyesOpen = eyesOpen
    }}
    
    @IBInspectable
    var linewith: CGFloat = 5.0 { didSet {
        leftEye.linewidth = linewith
        rightEye.linewidth = linewith
        setNeedsDisplay()
    }}
    
    @IBInspectable
    var color: UIColor = UIColor.blue { didSet {
        leftEye.color = color
        rightEye.color = color
        setNeedsDisplay()
    }}
    
    @IBInspectable
    var mouthCurvature: Double = -1.0 { didSet { setNeedsDisplay()}} // 1.0 - full smile, -1.0 - full frown
    
    
    // handler
    
    func changeScale (byReactingTo pinchRecognizer: UIPinchGestureRecognizer)
    {
        switch pinchRecognizer.state {
        case .changed, .ended:
            scale *= pinchRecognizer.scale
            pinchRecognizer.scale = 1
        default:
            break
        }
    }
    
    //Private Implementations

    
    private var skullRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height)/2 * scale
    }
    
    private var skullCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    
    private enum Eye {
        case left
        case right
    }
    
    private func centerForEye (_ eye: Eye) -> CGPoint {
        let eyeOffset = skullRadius / Ratios.skullRadioToTheEyeOffset
        var eyeCenter = skullCenter
        eyeCenter.y -= eyeOffset
        eyeCenter.x += ((eye == .left) ? -1 : 1) * eyeOffset
        return eyeCenter
    }
    
    private lazy var leftEye: EyeView = self.createEye()
    private lazy var rightEye: EyeView = self.createEye()

    
    private func createEye() -> EyeView {
        let eye = EyeView()
        eye.isOpaque = false
        eye.color = color
        eye.linewidth = linewith
        addSubview(eye)
        return eye
    }
    
    private func positionEye(_ eye: EyeView, center: CGPoint) {
        let size = skullRadius / Ratios.skullRadioToTheEyeRadius * 2
        eye.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: size, height: size))
        eye.center = center
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        positionEye(leftEye, center: centerForEye(.left))
        positionEye(rightEye, center: centerForEye(.right))
    }
    
//    private func pathForEye(_ eye: Eye) -> UIBezierPath
//    {
//        let eyeRadius = skullRadius / Ratios.skullRadioToTheEyeRadius
//        let eyeCenter = centerForEye(eye)
//        
//        let path: UIBezierPath
//        if eyesOpen {
//            path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
//        } else {
//            path = UIBezierPath()
//            path.move(to: CGPoint(x: eyeCenter.x - eyeRadius, y: eyeCenter.y))
//            path.addLine(to: CGPoint(x: eyeCenter.x + eyeRadius, y: eyeCenter.y))
//        }
//
//        path.lineWidth = linewith
//        return path
//    }
    
    private func pathForMouth () -> UIBezierPath
    {
        let mouthWidth = skullRadius / Ratios.skullRadioToMouthWidth
        let mouthHeight = skullRadius / Ratios.skullRadioToMouthHeight
        let mouthOffset = skullRadius / Ratios.skullRadioToMouthOffset
        
        let mouthRect = CGRect(
            x: skullCenter.x - mouthWidth / 2,
            y: skullCenter.y + mouthOffset,
            width: mouthWidth,
            height: mouthHeight
        )
        
        let smileOffset = CGFloat(max(-1, min(mouthCurvature, 1))) * mouthRect.height
        
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.midY)
        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.midY)
        
        let cp1 = CGPoint(x: start.x + mouthRect.width / 3, y: start.y + smileOffset)
        let cp2 = CGPoint(x: end.x - mouthRect.width / 3, y: start.y + smileOffset)

        
        let path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = linewith
        
        return path
    }
    
    private func pathForSkull () -> UIBezierPath
    {
        let path = UIBezierPath(arcCenter: skullCenter, radius: skullRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
        path.lineWidth = linewith
        return path
    }
    
    override func draw(_ rect: CGRect) {
        color.set()
        pathForSkull().stroke()
//        pathForEye(.right).stroke()
//        pathForEye(.left).stroke()
        pathForMouth().stroke()
    }

    private struct Ratios {
        static let skullRadioToTheEyeOffset: CGFloat = 3
        static let skullRadioToTheEyeRadius: CGFloat = 10
        static let skullRadioToMouthWidth: CGFloat = 1
        static let skullRadioToMouthHeight: CGFloat = 3
        static let skullRadioToMouthOffset: CGFloat = 3
    }
}
