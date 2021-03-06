//
//  TweetTableViewController.swift
//  Smash-Tag
//
//  Created by Kristina Gelzinyte on 9/13/17.
//  Copyright © 2017 Kristina Gelzinyte. All rights reserved.
//

import UIKit
import Twitter

class TweetTableViewController: UITableViewController, UISearchBarDelegate
{
    var tweets = [Array<Twitter.Tweet>]()
    
    private func twitterRequest() -> Twitter.Request? {
        if let query = searchText, !query.isEmpty {
            if query.contains("@") {
                let newQuery = query + " OR from:" + query
                return Twitter.Request(search: "\(newQuery) - filter:safe -filter:retweets", count: 100, resultType: .recent)
            } else {
                return Twitter.Request(search: "\(query) - filter:safe -filter:retweets", count: 100, resultType: .recent)
            }
        }
        return nil
    }
    
    func insertTweet(_ newTweets: [Twitter.Tweet]) {
        self.tweets.insert(newTweets, at: 0)
        self.tableView.insertSections([0], with: .fade)
    }
    
    private var lastTwitterRequest: Twitter.Request?
    
    private func searchForTweets() {
        if let request = lastTwitterRequest?.newer ?? twitterRequest() {
            lastTwitterRequest = request

            request.fetchTweets{ [weak self] newTweets in
                DispatchQueue.main.async {
                    if request == self?.lastTwitterRequest {
                        self?.insertTweet(newTweets)
                    }
                    self?.refreshControl?.endRefreshing()
                }
            }
        } else {
            self.refreshControl?.endRefreshing()
        }
    }
    
    @IBAction func refresh(_ sender: UIRefreshControl) {
        searchForTweets()
    }
    
    
    @IBOutlet weak var searchTextField: UISearchBar!
    
    private var userDefaultsManager = UserDefaultsManager()
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar == searchTextField {
            searchText = searchTextField.text
        }
    }
    var searchText: String? {
        didSet {
            searchTextField?.text = searchText
            searchTextField?.resignFirstResponder()
            tweets.removeAll()
            lastTwitterRequest = nil
            tableView.reloadData()
            searchForTweets()
            title = searchText
            
            if userDefaultsManager.twitterSearchHistory.count > 99 {
                userDefaultsManager.twitterSearchHistory.removeLast()
            }
            userDefaultsManager.twitterSearchHistory.insert(searchText!, at: userDefaultsManager.twitterSearchHistory.startIndex)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension

        searchTextField?.delegate = self
    }
    

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return tweets.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Tweet", for: indexPath)

        
        let tweet: Twitter.Tweet = tweets[indexPath.section][indexPath.row]
        if let tweetCell = cell as? TweetTableViewCell {
            tweetCell.tweet = tweet
        }
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "collection" {
            if let destinationViewController = (segue.destination.contents as? TweetCollectionViewController) {
                
                destinationViewController.tweets = tweets
                destinationViewController.navigationItem.title = searchText
            }
        }
        
        
        if segue.identifier == "mention" {
            if let destinationViewController = (segue.destination.contents as? MentionTableViewController) {
                
                let currentTweet = tweets[(tableView.indexPathForSelectedRow?.section)!][(tableView.indexPathForSelectedRow?.row)!]
                
                destinationViewController.tweet = currentTweet
                destinationViewController.navigationItem.title = currentTweet.user.name
            }
        }
    }
}























