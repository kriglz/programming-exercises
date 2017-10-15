//
//  TweetCollectionViewController.swift
//  Smash-Tag
//
//  Created by Kristina Gelzinyte on 10/11/17.
//  Copyright © 2017 Kristina Gelzinyte. All rights reserved.
//

import UIKit
import Twitter

@IBDesignable
class TweetCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let imageCache = NSCache<AnyObject, AnyObject>()
    
    var tweets = [Array<Twitter.Tweet>]() 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView?.collectionViewLayout = layout
        
        //pinch handler
        let handler = #selector(TweetCollectionViewController.changeScale(byReactingTo:))
        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: handler)
        collectionView?.addGestureRecognizer(pinchRecognizer)
    }
    
    
    
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return tweets.count
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {   
        return tweets[section].count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath)
        
        let tweet: Twitter.Tweet = tweets[indexPath.section][indexPath.row]
        if let tweetCell = cell as? TweetCollectionViewCell {
            tweetCell.tweetIndex = [indexPath.section, indexPath.row]
            tweetCell.imageCache = imageCache
            
            if !tweet.media.isEmpty {
                for media in tweet.media {
                    tweetCell.tweetURL = media.url
                }
            } else {
                tweetCell.tweetURL = tweet.user.profileImageURL!
            }
        }
        return cell
    }

    
    
     // MARK: - Navigation
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {        
        if segue.identifier == "collMention" {
            if let destinationViewController = (segue.destination.contents as? TweetTableViewController) {
                let cell = sender as! TweetCollectionViewCell
                let indexPaths = self.collectionView?.indexPath(for: cell)

                let currentTweet = tweets[(indexPaths?.section)!][(indexPaths?.row)!]
                destinationViewController.tweets = [[currentTweet]]
            }
        }
     }
 
    

    //LAYOUT
    
    fileprivate var itemsPerRow: CGFloat = 3.0
    
    @IBInspectable
    fileprivate var sectionInsets = UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0) {
        didSet {
            collectionView?.collectionViewLayout.invalidateLayout()
        }
    }
    
    func changeScale (byReactingTo pinchRecognizer: UIPinchGestureRecognizer)
    {
        switch pinchRecognizer.state {
        case .changed, .ended:
            sectionInsets.bottom /= pinchRecognizer.scale
            sectionInsets.top /= pinchRecognizer.scale
            sectionInsets.left /= pinchRecognizer.scale
            sectionInsets.right /= pinchRecognizer.scale
            itemsPerRow /= pinchRecognizer.scale
            pinchRecognizer.scale = 1
        default:
            break
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let widthPerItem = (view.frame.width - 2*paddingSpace)/itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
}
