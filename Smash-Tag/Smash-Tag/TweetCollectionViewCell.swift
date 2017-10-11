//
//  TweetCollectionViewCell.swift
//  Smash-Tag
//
//  Created by Kristina Gelzinyte on 10/11/17.
//  Copyright © 2017 Kristina Gelzinyte. All rights reserved.
//

import UIKit
import Twitter

class TweetCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var tweetURL: URL? {didSet{updateUI()}}
    
    private func updateUI() {
        print(tweetURL)
        
        if let profileImageURL = tweetURL {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                if let imageData = try? Data(contentsOf: profileImageURL) {
                    if profileImageURL == self?.tweetURL {
                        DispatchQueue.main.async {
                            self?.imageView?.image = UIImage(data: imageData)
                        }
                    }
                }
            }
        } else {
            imageView?.image = nil
        }
    }
  
}
