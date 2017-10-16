//
//  DetailTweetTableViewController.swift
//  Smash-Tag
//
//  Created by Kristina Gelzinyte on 10/15/17.
//  Copyright © 2017 Kristina Gelzinyte. All rights reserved.
//

import UIKit
import CoreData

class DetailTweetTableViewController: FetchedResultsTableViewController {

//    var mention: String? { didSet{ updateUI()}}
//    
//    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer { didSet{ updateUI()}}
//    
    var fetchedResultsController: NSFetchedResultsController<TwitterUser>?
//    
//    private func updateUI(){
//        if let context = container?.viewContext, mention != nil {
//            let request: NSFetchRequest<TwitterUser> = TwitterUser.fetchRequest()
//            request.sortDescriptors = [NSSortDescriptor(key: "handle", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))]
//            request.predicate = NSPredicate(format: "any tweets.text contains[c] %@", mention!)
//            fetchedResultsController = NSFetchedResultsController<TwitterUser>(
//                fetchRequest: request,
//                managedObjectContext: context,
//                sectionNameKeyPath: nil,
//                cacheName: nil
//            )
//            fetchedResultsController?.delegate = self
//            try? fetchedResultsController?.performFetch()
//            tableView.reloadData()
//        }
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TwitterUser Cell", for: indexPath)
//        
//        if let twitterUser = fetchedResultsController?.object(at: indexPath) {
//            cell.textLabel?.text = twitterUser.handle
//            let tweetCount = tweetCountWithMentionBy(twitterUser)
//            cell.detailTextLabel?.text = "\(tweetCount) tweet\((tweetCount == 1) ? "" : "s")"
//        }
//        return cell
//    }
//    
//    private func tweetCountWithMentionBy(_ twitterUser: TwitterUser) -> Int {
//        let request: NSFetchRequest<Tweet> = Tweet.fetchRequest()
//        request.predicate = NSPredicate(format: "text contains[c] %@ and tweeter = %@", mention!, twitterUser)
//        return (try? twitterUser.managedObjectContext!.count(for: request)) ?? 0
//    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController?.sections?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController?.sections, sections.count > 0 {
            return sections[section].numberOfObjects
        } else  {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let sections = fetchedResultsController?.sections, sections.count > 0 {
            return sections[section].name
        } else {
            return nil
        }
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return fetchedResultsController?.sectionIndexTitles
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return fetchedResultsController?.section(forSectionIndexTitle: title, at: index) ?? 0
    }

}
