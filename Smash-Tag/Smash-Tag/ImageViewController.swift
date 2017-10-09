//
//  ImageViewController.swift
//  Smash-Tag
//
//  Created by Kristina Gelzinyte on 9/28/17.
//  Copyright © 2017 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        self.scrollView.delegate = self
        scrollView.minimumZoomScale = 0.7
        scrollView.maximumZoomScale = 1.5
        scrollView.contentSize = view.frame.size
    }
    
    @IBOutlet weak var singleImageView: UIImageView!
        
    private var image: UIImage? {
        get {
            return singleImageView.image
        }
        set {
            singleImageView.image = newValue
            scrollView?.contentSize = singleImageView.frame.size
            scrollView?.addSubview(singleImageView)
        }
        
    }

    var singleImageUrl: URL? {didSet{updateUI()}}
    
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
        return singleImageView
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateViewConstraints()
    }
}
