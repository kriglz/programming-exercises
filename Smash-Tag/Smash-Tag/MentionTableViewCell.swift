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
    
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var mentionAsTextLabel: UILabel!

    
    private func updateUI() {
      
        mentionAsTextLabel.text = mentionAsText
        
    }
    
//        override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
