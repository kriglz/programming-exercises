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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    

        let context = CIContext()                                           // 1
        
        let filter = CIFilter(name: "CISepiaTone")!                         // 2
        filter.setValue(0.8, forKey: kCIInputIntensityKey)
        let image = CIImage(image: UIImage.init(named: "test")!)
        filter.setValue(image, forKey: kCIInputImageKey)
        let result = filter.outputImage!                                    // 4
        let cgImage = context.createCGImage(result, from: result.extent)    // 5
        
        firstImage.image = UIImage(ciImage: image!)
        secondImage.image = UIImage(cgImage: cgImage!)
    }
    

}

