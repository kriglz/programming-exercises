//
//  ImageViewController.swift
//  Smash-Tag
//
//  Created by Kristina Gelzinyte on 9/28/17.
//  Copyright © 2017 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var singleImageView: UIImageView!
    var singleImageUrl: URL? { didSet {updateUI()}}
        
    private func updateUI() {
        
        if let profileImageURL = singleImageUrl {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                if let imageData = try? Data(contentsOf: profileImageURL) {
                    if profileImageURL == self?.singleImageUrl {
                        DispatchQueue.main.async {
                            //Loading the image
                            self?.singleImageView?.image = UIImage(data: imageData)
                            
//                            //Resizing to fit the screen
//                            let imageSize = CGSize(width: (self?.width)!, height: (self?.bounds.height)!)
//                            UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
//                            self?.singleImageView?.image?.draw(in: CGRect(origin: CGPoint.zero, size: imageSize ))
//                            self?.singleImageView?.image = UIGraphicsGetImageFromCurrentImageContext()
//                            UIGraphicsEndImageContext()
                        }
                        
                    }
                }
            }
        } else {
            singleImageView?.image = nil
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
