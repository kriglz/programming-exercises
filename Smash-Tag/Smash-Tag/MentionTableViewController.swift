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
            
            func convert(elements: [Mention]) -> [TypeOfMention] {
                var elementArray = [TypeOfMention]()
                for element in elements {
                    elementArray.append(.text(element.keyword))
                }
                return elementArray
            }
            
            func convertM(elements: [MediaItem]) -> [TypeOfMention] {
                var elementArray = [TypeOfMention]()
                for element in elements {
                    elementArray.append(.media(element.url))
                    mediaaspAspectRatio.append(element.aspectRatio)
                }
                return elementArray
            }
            
            if !(tweet?.media.isEmpty)! {
                mentionsArray.append(convertM(elements: (tweet?.media)!))
                mentionTitles.append("Pictures")
            }
            
            if !(tweet?.hashtags.isEmpty)! {
                mentionsArray.append(convert(elements: (tweet?.hashtags)!))
                mentionTitles.append("Hashtags")
            }
            if !(tweet?.userMentions.isEmpty)! {
                mentionsArray.append(convert(elements: (tweet?.userMentions)!))
                mentionTitles.append("Users")
            }
            if !(tweet?.urls.isEmpty)! {
                mentionsArray.append(convert(elements: (tweet?.urls)!))
                mentionTitles.append("URLs")
            }
        }
    }
    
    private enum TypeOfMention {
        case text(String)
        case media(URL)
    }

    private var mentionsArray = [[TypeOfMention]]()
    private var mentionTitles = [String]()
    private var mediaaspAspectRatio = [Double]()

    
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
        var cell: UITableViewCell?
        let cellMention = mentionsArray[indexPath.section][indexPath.row]
                
        switch cellMention {
        case .text(let stringBe):
            cell = tableView.dequeueReusableCell(withIdentifier: "text", for: indexPath)
            if let tweetCell = cell as? MentionTableViewCell {
                tweetCell.mentionAsText = stringBe
            }
            
        case .media(let urlBe):
            cell = tableView.dequeueReusableCell(withIdentifier: "media", for: indexPath)
            if let tweetCell = cell as? MentionTableViewCell {
                tweetCell.mentionAsUrl = urlBe
                print(urlBe)
            }
            
        

        }
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let cellMention = mentionsArray[indexPath.section][indexPath.row]
        
        switch cellMention {
        case .text:
                tableView.rowHeight = 40.0
                tableView.rowHeight = UITableViewAutomaticDimension
            
        case .media:
                tableView.rowHeight = tableView.bounds.size.width / CGFloat(mediaaspAspectRatio[indexPath.row])

        }
        
        return tableView.rowHeight
    }
    
    
    
    
    
    /*
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}
