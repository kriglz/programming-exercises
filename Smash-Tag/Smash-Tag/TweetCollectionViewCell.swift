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
    var tweetIndex: [IndexPath.Element] = []
    var imageCache: NSCache<AnyObject, AnyObject>?
    
    private func updateUI() {
        if let image = imageCache?.object(forKey: tweetIndex as AnyObject)
        {
           imageView?.image = image as? UIImage
        } else {
            if let imageURL = tweetURL {
                DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                    if let imageData = try? Data(contentsOf: imageURL) {
                        if imageURL == self?.tweetURL {
                            DispatchQueue.main.async {
                                self?.imageCache?.setObject( UIImage(data: imageData)!, forKey: self?.tweetIndex as AnyObject)
                                self?.imageView?.image = self?.imageCache?.object(forKey: self?.tweetIndex as AnyObject) as? UIImage
                            }
                        }
                    }
                }
            } else {
                 imageView?.image = nil
            }
        }
    }
}
