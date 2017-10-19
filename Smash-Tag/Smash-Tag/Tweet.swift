//
//  Tweet.swift
//  Smash-Tag
//
//  Created by Kristina Gelzinyte on 10/15/17.
//  Copyright © 2017 Kristina Gelzinyte. All rights reserved.
//

import UIKit
import CoreData
import Twitter

class Tweet: NSManagedObject {

    class func findOrCreateTweet(matching twitterInfo: Twitter.Tweet, in context: NSManagedObjectContext) throws -> Tweet {
        let request: NSFetchRequest<Tweet> = Tweet.fetchRequest()
        request.predicate = NSPredicate(format: "unique = %@", twitterInfo.identifier)
        
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                assert(matches.count == 1, "Tweet.findOrCreateTweet database inconsistency")
                return matches[0]
            }
        } catch {
            throw error
        }
        
        let tweet = Tweet(context: context)
        tweet.unique = twitterInfo.identifier
        tweet.text = twitterInfo.text
        tweet.created = twitterInfo.created as NSDate
         
        return tweet
    }
}
