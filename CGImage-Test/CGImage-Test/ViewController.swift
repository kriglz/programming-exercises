//
//  ViewController.swift
//  CGImage-Test
//
//  Created by Kristina Gelzinyte on 1/5/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import AVFoundation
import AVKit
import UIKit
import CoreImage

class ViewController: UIViewController {

    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var thirdImage: UIImageView!
    @IBOutlet weak var fourthImage: UIImageView!
    @IBOutlet weak var videoView: UIView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        playVideo()
        
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

        applyFilterToVideo()

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
    
    func applyFilterToVideo(){
        let filter = CIFilter(name: "CIGaussianBlur")!
        
        let asset = AVAsset(url: URL.init(string: "/Users/kriglz/Desktop/IMG_0614.TRIM.mov")!)
        
        let composition = AVVideoComposition(asset: asset, applyingCIFiltersWithHandler: { request in
            
            // Clamp to avoid blurring transparent pixels at the image edges
            let source = request.sourceImage.clampedToExtent()
            filter.setValue(source, forKey: kCIInputImageKey)
            
            // Vary filter parameters based on video timing
            let seconds = CMTimeGetSeconds(request.compositionTime)
            filter.setValue(seconds * 10.0, forKey: kCIInputRadiusKey)
            
            // Crop the blurred output to the bounds of the original image
            let output = filter.outputImage!.cropped(to: request.sourceImage.extent)
            
            // Provide the filter output to the composition
            request.finish(with: output, context: nil)
        })
        
        let export = AVAssetExportSession(asset: asset, presetName: AVAssetExportPreset1920x1080)!
        export.outputFileType = AVFileType.mov
        export.outputURL = URL.init(string: "/Users/kriglz/Desktop/")
        export.videoComposition = composition
        
        export.exportAsynchronously(completionHandler: {print("done")})
    }
    
    
    //    @IBOutlet weak var playerView: PlayerView!
    
    func playVideo() {
        
        guard let url = URL(string: "https://devimages-cdn.apple.com/samplecode/avfoundationMedia/AVFoundationQueuePlayer_HLS2/master.m3u8") else {
            return
        }
        
        let player = AVPlayer.init(url: url)
        let controller = AVPlayerViewController()
        present(controller, animated: true)
        addChildViewController(controller)
        videoView.addSubview(controller.view)
        controller.view.frame = videoView.bounds
        controller.player = player
        player.play()
    }
}

