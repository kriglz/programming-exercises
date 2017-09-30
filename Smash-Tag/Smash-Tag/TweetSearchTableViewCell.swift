//
//  TweetSearchTableViewCell.swift
//  Smash-Tag
//
//  Created by Kristina Gelzinyte on 9/30/17.
//  Copyright © 2017 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class TweetSearchTableViewCell: UITableViewCell {

    var textSearch: String? { didSet{updateUI()}}
    
    @IBOutlet weak var textOfTweetSearchHistory: UILabel!

    private func updateUI() {
        textOfTweetSearchHistory.text = textSearch
    }
    
}
