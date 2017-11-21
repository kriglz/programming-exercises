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

    var mention: String? { didSet{ updateUI()}}
    
    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer { didSet{ updateUI()}}
    
    var fetchedResultsController: NSFetchedResultsController<Mention>?
    
    private func updateUI(){
      
//        if let context = container?.viewContext, mention != nil {
//            let request: NSFetchRequest<Mention> = Mention.fetchRequest()
//            
//            request.sortDescriptors = [NSSortDescriptor(key: "handle", ascending: false)]
//            request.predicate = NSPredicate(format: "handle = [c] %@", mention!)
//            
//            fetchedResultsController = NSFetchedResultsController<Mention>(
//                fetchRequest: request,
//                managedObjectContext: context,
//                sectionNameKeyPath: nil,
//                cacheName: nil
//            )
//            fetchedResultsController?.delegate = self
//            try? fetchedResultsController?.performFetch()
//            tableView.reloadData()
//        }
    }

    
    
    
    
    private func tweetCountWithMentionBy(_ mention: Mention) -> Int {
        let request: NSFetchRequest<Mention> = Mention.fetchRequest()
        request.predicate = NSPredicate(format: "handle = [c] %@", mention.handle!)
        let matches = try? mention.managedObjectContext?.fetch(request)
        let number =  matches??[0].unique?.count
        
        return number ?? 0
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detail cell", for: indexPath)
        
        if let mention = fetchedResultsController?.object(at: indexPath) {
            cell.textLabel?.text = mention.handle
            
            let mentionNumber = tweetCountWithMentionBy(mention)
            
            cell.detailTextLabel?.text = "\(mentionNumber) tweet\((mentionNumber == 1) ? "" : "s")"
        }
        return cell
    }
    
    
    
    


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
