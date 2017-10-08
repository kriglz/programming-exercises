//
//  TweetSearchTableViewController.swift
//  Smash-Tag
//
//  Created by Kristina Gelzinyte on 9/30/17.
//  Copyright © 2017 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class UserDefaultsManager {
    private let twitterSearchHistoryKey = "twitterSearch"
    private let twitterUserDefaults = UserDefaults.standard
    
    var twitterSearchHistory: [String] {
        get {
            return twitterUserDefaults.stringArray(forKey: twitterSearchHistoryKey)!
        }
        set {
            twitterUserDefaults.set(newValue, forKey: twitterSearchHistoryKey)
        }
    }
}







class TweetSearchTableViewController: UITableViewController {
    
    private var userDefaultsManager = UserDefaultsManager()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDefaultsManager.twitterSearchHistory.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "text", for: indexPath)
        let cellText =  userDefaultsManager.twitterSearchHistory[indexPath.row]
        
        if let tweetCell = cell as? TweetSearchTableViewCell {
            tweetCell.textSearch = cellText
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = (segue.destination.contents as? TweetTableViewController) {
            
            let currentTweet = userDefaultsManager.twitterSearchHistory[(tableView.indexPathForSelectedRow?.row)!]
            
            destinationViewController.searchText = currentTweet
        }
    }
}

extension UIViewController
{
    var contents: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        } else {
            return self
        }
    }
}
