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
    
    var tweet: Twitter.Tweet? {
        didSet {
            makeAMentionsArray(of: Keywords.hashtags)
            makeAMentionsArray(of: Keywords.userMentions)
            makeAMentionsArray(of: Keywords.urls)            
        }
    }
    
    private enum TypeOfMention {
        case text
        case media
    }

    private enum Keywords {
        case media
        case hashtags
        case userMentions
        case urls
    }
    
    private var mentionsArray = [[String]]()
    private var mentionTitles = [String]()

    private func makeAMentionsArray(of: Keywords) {
        switch of {
        case .hashtags:
            if let hashtags = tweet?.hashtags {
                if !hashtags.isEmpty {
                    mentionsArray.append(addElements(hashtags))
                    mentionTitles.append("Hashtags")
                }
            }
            
        case .userMentions:
            if let userMentions = tweet?.userMentions {
                if !userMentions.isEmpty {
                    mentionsArray.append(addElements(userMentions))
                    mentionTitles.append("Users")
                }
            }
            
        case .urls:
            if let urls = tweet?.urls {
                if !urls.isEmpty {
                    mentionsArray.append(addElements(urls))
                    mentionTitles.append("Images")
                }
            }
        
        default:
            break
        }
    }
    
    private func addElements(_ mentions: [Mention]) -> [String] {
        var array = [String]()
        
        for element in mentions {
            array.append(element.keyword)
        }
        return array
    }
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return mentionsArray.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {        
        return mentionTitles[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mentionsArray[section].count
    }
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellMention = mentionsArray[indexPath.section][indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "text", for: indexPath)
        if let tweetCell = cell as? MentionTableViewCell {
            tweetCell.mentionAsText = cellMention
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 40.0
    }

    

    
   
    /*
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}
