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
    private var tweets = [Array<Twitter.Tweet>]()
    
    private func twitterRequest() -> Twitter.Request? {
        if let query = searchText, !query.isEmpty {
            return Twitter.Request(search: query, count: 100)
        }
        return nil
    }
    
    private var lastTwitterRequest: Twitter.Request?
    
    private func searchForTweets() {
        if let request = twitterRequest() {
            lastTwitterRequest = request

            request.fetchTweets{ [weak self] newTweets in
                DispatchQueue.main.async {
                    if request == self?.lastTwitterRequest {
                        self?.tweets.insert(newTweets, at: 0)
                        self?.tableView.insertSections([0], with: .fade)
                    }
                }
            }
        }
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

        
        let tweet: Tweet = tweets[indexPath.section][indexPath.row]
        if let tweetCell = cell as? TweetTableViewCell {
            tweetCell.tweet = tweet
        }
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = (segue.destination.contents as? MentionTableViewController) {
            
            let currentTweet = tweets[(tableView.indexPathForSelectedRow?.section)!][(tableView.indexPathForSelectedRow?.row)!]
            
            destinationViewController.tweet = currentTweet
            destinationViewController.navigationItem.title = currentTweet.user.name
        }
    }
}























