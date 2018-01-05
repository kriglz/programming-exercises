//
//  ViewController.swift
//  CGImage-Test
//
//  Created by Kristina Gelzinyte on 1/5/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController {

    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var thirdImage: UIImageView!
    @IBOutlet weak var fourthImage: UIImageView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let context = CIContext()
        
        let filter = CIFilter(name: "CISepiaTone")!
        filter.setValue(0.8, forKey: kCIInputIntensityKey)
        let image = CIImage(image: UIImage.init(named: "test")!)
        filter.setValue(image, forKey: kCIInputImageKey)
        let result = filter.outputImage!
        let cgImage = context.createCGImage(result, from: result.extent)
        
        firstImage.image = UIImage(ciImage: image!)
        secondImage.image = UIImage(cgImage: cgImage!)
        
        let croppedImage = applyFilterChain(to: image!)
        let cgCroppedImage = context.createCGImage(croppedImage, from: croppedImage.extent)
        thirdImage.image = UIImage(cgImage: cgCroppedImage!)
        
        let checkers = CIFilter(name: "CICheckerboardGenerator")!
        checkers.setValue(CIColor.black, forKey: "inputColor0")
        checkers.setValue(CIColor.yellow, forKey: "inputColor1")
        checkers.setValue(5.0, forKey: kCIInputWidthKey)
        let imageCheckers = checkers.outputImage
        let cgImageCheckers = context.createCGImage(imageCheckers!, from: CGRect(origin: CGPoint.zero, size: CGSize(width: 100, height: 100)))
        fourthImage.image = UIImage(cgImage: cgImageCheckers!)
    }
    
    func applyFilterChain(to image: CIImage) -> CIImage {
        // The CIPhotoEffectInstant filter takes only an input image
        let colorFilter = CIFilter(name: "CIPhotoEffectProcess", withInputParameters: [kCIInputImageKey: image])!
        
        // Pass the result of the color filter into the Bloom filter
        // and set its parameters for a glowy effect.
        let bloomImage = colorFilter.outputImage!.applyingFilter("CIBloom",
                                                                 parameters: [kCIInputRadiusKey: 10.0,
                                                                              kCIInputIntensityKey: 1.0])
        
        // imageByCroppingToRect is a convenience method for
        // creating the CICrop filter and accessing its outputImage.
        let cropRect = CGRect(x: 350, y: 550, width: 450, height: 350)
        let croppedImage = bloomImage.cropped(to: cropRect)
        return croppedImage
    }

}

