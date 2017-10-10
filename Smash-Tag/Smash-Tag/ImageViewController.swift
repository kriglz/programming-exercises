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
    
//    @IBOutlet weak var singleImageView: UIImageView!
    
    fileprivate var singleImageView = UIImageView()
    private var image: UIImage? {
        get {
            return singleImageView.image
        }
        set {
            singleImageView.image = newValue
            singleImageView.frame = view.bounds
            singleImageView.contentMode = .scaleAspectFit

            scrollView?.contentSize = singleImageView.frame.size
            scrollView?.addSubview(singleImageView)
        }
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        singleImageView.frame.size = size
        scrollView?.contentSize = size
        singleImageView.contentMode = .scaleAspectFit
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
