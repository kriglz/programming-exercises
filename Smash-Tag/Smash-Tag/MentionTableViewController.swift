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
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        tableView.reloadData()
    }
    
    var tweet: Twitter.Tweet? {
        didSet {
            
            //Crating new data structure for tweets
            func convert(elements: [Twitter.Mention]) -> [TypeOfMention] {
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
            
            
            let userNameString = String("@" + (tweet?.user.screenName)!)
            var tweetUserArray = [TypeOfMention.text(userNameString!)]
            if !(tweet?.userMentions.isEmpty)! {
                
                let userMentionsArray = convert(elements: (tweet?.userMentions)!)
                
                for element in userMentionsArray {
                    tweetUserArray.append(element)
                }
            }
            mentionsArray.append(tweetUserArray)
            mentionTitles.append("Users")
            
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
            if !stringBe.isStringLink() {
                cell = tableView.dequeueReusableCell(withIdentifier: "text", for: indexPath)
                if let tweetCell = cell as? MentionTableViewCell {
                    tweetCell.mentionAsText = stringBe
                }
            } else {
                cell = tableView.dequeueReusableCell(withIdentifier: "web", for: indexPath)
                if let tweetCell = cell as? MentionTableViewCell {
                    tweetCell.mentionAsText = stringBe
                }
            }
                
        case .media(let urlBe):
            cell = tableView.dequeueReusableCell(withIdentifier: "media", for: indexPath)
            if let tweetCell = cell as? MentionTableViewCell {
                tweetCell.mentionAsUrl = urlBe
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
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let currentCell = mentionsArray[(tableView.indexPathForSelectedRow?.section)!][(tableView.indexPathForSelectedRow?.row)!]
        
        switch currentCell {
        case .text(let text):
            if segue.identifier == "webView" {
                if text.isStringLink() {
                    let url = URL(string: text)
                    
                    if let destinationViewController = (segue.destination.contents as? WebViewController) {
                        destinationViewController.webURL = url
                    }                    
                }
            }
            if segue.identifier == "textSearch" {
                
                if let destinationViewController = (segue.destination.contents as? TweetTableViewController) {
                    destinationViewController.searchText = text
                    destinationViewController.navigationItem.backBarButtonItem?.title = text
                    destinationViewController.tabBarController?.tabBar.isHidden = false
                }
            }
            
        case .media(let url):
            if segue.identifier == "image" {
                if let destinationViewController = (segue.destination as? ImageViewController) {
                    
                    destinationViewController.navigationController?.setNavigationBarHidden(false, animated: false)
                    destinationViewController.singleImageUrl = url
                }
            }
        }
    }
}





extension String {
    func isStringLink() -> Bool {
        let types: NSTextCheckingResult.CheckingType = [.link]
        let detector = try? NSDataDetector(types: types.rawValue)
        guard (detector != nil && self.characters.count > 0)
            else {
                return false
        }
        if detector!.numberOfMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) > 0 {
            return true
        }
        return false
    }
}
