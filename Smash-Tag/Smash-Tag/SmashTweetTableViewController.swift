//
//  SmashTweetTableViewController.swift
//  Smash-Tag
//
//  Created by Kristina Gelzinyte on 10/15/17.
//  Copyright © 2017 Kristina Gelzinyte. All rights reserved.
//

import UIKit
import Twitter
import CoreData

class SmashTweetTableViewController: TweetTableViewController {
    
    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    override func insertTweet(_ newTweets: [Twitter.Tweet]) {
        super.insertTweet(newTweets)
        updateDatabase(with: newTweets)
    }
   
    private func updateDatabase(with tweets: [Twitter.Tweet]) {
        container?.performBackgroundTask{ [weak self] context in
            for twitterInfo in tweets {
                _ = try? Tweet.findOrCreateTweet(matching: twitterInfo, in: context)
            }
            try? context.save()
            self?.printDatabaseStatistcs()
        }
    }
    
    private func printDatabaseStatistcs() {
        if let context = container?.viewContext {
            context.perform {
                let request: NSFetchRequest<Tweet> = Tweet.fetchRequest()
                if let tweetCount = (try? context.fetch(request))?.count {
                    print("\(tweetCount) tweets")
                }
                
                if let tweeterVount = try? context.count(for: TwitterUser.fetchRequest()){
                    print("\(tweeterVount) Twitter users")
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Tweeters Mentioning Search Term" {
            if let tweetersTVC = segue.destination.contents as? SmashTweetersTableViewController {
                tweetersTVC.mention = searchText
                tweetersTVC.container = container
            }
        }
    }
}
