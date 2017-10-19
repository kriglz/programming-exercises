//
//  Mention.swift
//  Smash-Tag
//
//  Created by Kristina Gelzinyte on 10/18/17.
//  Copyright © 2017 Kristina Gelzinyte. All rights reserved.
//

import UIKit
import CoreData
import Twitter

class Mention: NSManagedObject {

    class func findOrCreateTwitterMention(matching twitterInfo: String, in context: NSManagedObjectContext) throws -> Mention
    {
        let request: NSFetchRequest<Mention> = Mention.fetchRequest()
        
        request.predicate = NSPredicate(format: "handle = [c]%@", twitterInfo)
        
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                //that mention does exist
                matches[0].number += 1
                return matches[0]
            }
        } catch {
            throw error
        }
        
        let mention = Mention(context: context)
        mention.handle = twitterInfo
        mention.number = 1
        
        return mention
        
    }
}

