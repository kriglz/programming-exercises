//
//  TweetTableViewCell.swift
//  Smash-Tag
//
//  Created by Kristina Gelzinyte on 9/18/17.
//  Copyright © 2017 Kristina Gelzinyte. All rights reserved.
//

import UIKit
import Twitter

class TweetTableViewCell: UITableViewCell
{
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetCreatedLabel: UILabel!
    @IBOutlet weak var tweetUserLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    var tweet: Twitter.Tweet? { didSet{ updateUI()}}
    
    private func updateUI() {
        
        let text = tweet?.text
        let textAttributed = NSAttributedString(string: text!)
        let textFinal = NSMutableAttributedString(attributedString: textAttributed)
        
        func changeTextColor(of mentions: [Twitter.Mention], with color: UIColor) {
            for mention in mentions {
                let length = mention.nsrange.length
                let location = mention.nsrange.location
                
                textFinal.addAttribute(NSForegroundColorAttributeName, value: color, range: NSRange(location: location, length: length ))
                
                tweetTextLabel?.attributedText = textFinal
            }
        }
        
        let userMentions = tweet?.userMentions
        changeTextColor(of: userMentions!, with: .red)
        let urls = tweet?.urls
        changeTextColor(of: urls!, with: .orange)
        let hashtags = tweet?.hashtags
        changeTextColor(of: hashtags!, with: .blue)
        
        
        
        tweetUserLabel?.text = tweet?.user.description
        
        if let profileImageURL = tweet?.user.profileImageURL {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                if let imageData = try? Data(contentsOf: profileImageURL) {
                    if profileImageURL == self?.tweet?.user.profileImageURL {
                        DispatchQueue.main.async {
                            self?.tweetProfileImageView?.image = UIImage(data: imageData)
                        }
                    }
                }
            }
        } else {
            tweetProfileImageView?.image = nil
        }
        
        if let created = tweet?.created {
            let formatter = DateFormatter()
            if Date().timeIntervalSince(created) > 24 * 60 * 60 {
                formatter.dateStyle = .short
            } else {
                formatter.timeStyle = .short
            }
            tweetCreatedLabel?.text = formatter.string(from: created)
        } else {
            tweetCreatedLabel?.text = nil
        }
    }
}
