//
//  TweetSearchTableViewController.swift
//  Smash-Tag
//
//  Created by Kristina Gelzinyte on 9/30/17.
//  Copyright © 2017 Kristina Gelzinyte. All rights reserved.
//

import UIKit
import CoreData

//Saving History of Tweet Search Terms

class UserDefaultsManager {
    private let twitterSearchHistoryKey = "twitterSearch"
    private let twitterUserDefaults = UserDefaults.standard
    
    var twitterSearchHistory: [String] {
        get {
            if let searchText = twitterUserDefaults.stringArray(forKey: twitterSearchHistoryKey) {
                return searchText
            } else {
                return []
            }
        }
        set {
            twitterUserDefaults.set(newValue, forKey: twitterSearchHistoryKey)
        }
    }
}







class TweetSearchTableViewController: UITableViewController {
    
    private var userDefaultsManager = UserDefaultsManager()
    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer

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
        cell.accessoryType = .detailDisclosureButton
        let cellText =  userDefaultsManager.twitterSearchHistory[indexPath.row]
        
        if let tweetCell = cell as? TweetSearchTableViewCell {
            tweetCell.textSearch = cellText
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            userDefaultsManager.twitterSearchHistory.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
        let currentTweet = userDefaultsManager.twitterSearchHistory[indexPath.row]
        
        if segue.identifier == "search" {
            if let destinationViewController = (segue.destination.contents as? TweetTableViewController) {
                destinationViewController.searchText = currentTweet
            }
        }
        
        if segue.identifier == "detailTable" {
            if let destinationViewController = (segue.destination.contents as? DetailTweetTableViewController) {
                destinationViewController.mention = currentTweet
                destinationViewController.container = container
            }
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
