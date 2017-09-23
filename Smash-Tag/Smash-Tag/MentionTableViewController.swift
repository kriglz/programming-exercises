//
//  MentionTableViewController.swift
//  Smash-Tag
//
//  Created by Kristina Gelzinyte on 9/20/17.
//  Copyright © 2017 Kristina Gelzinyte. All rights reserved.
//

import UIKit
import Twitter

class MentionTableViewController: UITableViewController {

    var tweet: Twitter.Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }

    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {        
        return "Hashtags"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweet?.hashtags.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hashtags", for: indexPath)
        
        if let tweetCell = cell as? MentionTableViewCell {
            if let tweetHashtags = tweet?.hashtags {
                tweetCell.tweetHashtag = tweetHashtags[indexPath.row].keyword
            }
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 30.0
    }

    

    
   
    /*
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}
