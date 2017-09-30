//
//  ImageViewController.swift
//  Smash-Tag
//
//  Created by Kristina Gelzinyte on 9/28/17.
//  Copyright © 2017 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            self.scrollView.delegate = self
            scrollView.minimumZoomScale = 0.3
            scrollView.maximumZoomScale = 2.0
            scrollView.contentSize = imageView.frame.size
            scrollView.addSubview(imageView)
        }
    }
    
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var imageView = UIImageView()
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()

//            imageView.contentMode = .scaleAspectFit
            scrollView?.contentSize = imageView.frame.size
        }
        
    }

    var singleImageUrl: URL? {didSet{

        updateUI()
}}
    
    private func updateUI() {
        
        if let profileImageURL = singleImageUrl {

            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                if let imageData = try? Data(contentsOf: profileImageURL) {
                    if profileImageURL == self?.singleImageUrl {
                        DispatchQueue.main.async {
                            self?.image = UIImage(data: imageData)
                        }
                    }
                }
            }
        }
    }
}

extension ImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
}
