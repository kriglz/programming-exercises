//
//  MentionTableViewCell.swift
//  Smash-Tag
//
//  Created by Kristina Gelzinyte on 9/23/17.
//  Copyright © 2017 Kristina Gelzinyte. All rights reserved.
//

import UIKit
import Twitter

class MentionTableViewCell: UITableViewCell {

    var mentionAsText: String? {didSet{ updateUI()}}
    var mentionAsUrl: URL? {didSet{ updateUI()}}
    
    @IBOutlet weak var mentionAsTextLabel: UILabel!
    @IBOutlet weak var mentionImageView: UIImageView!

    
    private func updateUI() {
      
        mentionAsTextLabel?.text = mentionAsText
        
        if let profileImageURL = mentionAsUrl {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                if let imageData = try? Data(contentsOf: profileImageURL) {
                    if profileImageURL == self?.mentionAsUrl {
                        DispatchQueue.main.async {
                            //Loading the image
                            self?.mentionImageView?.image = UIImage(data: imageData)
                            
                            //Resizing to fit the screen
                            let imageSize = CGSize(width: (self?.bounds.width)!, height: (self?.bounds.height)!)
                            UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
                            self?.mentionImageView?.image?.draw(in: CGRect(origin: CGPoint.zero, size: imageSize ))
                            self?.mentionImageView?.image = UIGraphicsGetImageFromCurrentImageContext()
                            UIGraphicsEndImageContext()
                        }
                        
                    }
                }
            }
        } else {
            mentionImageView?.image = nil
        }
    }
}
