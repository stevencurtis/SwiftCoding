//
//  GitCommit+CoreDataClass.swift
//  CoreDataPredicate
//
//  Created by Steven Curtis on 18/06/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//
//

import Foundation
import CoreData

@objc(GitCommit)
public class GitCommit: NSManagedObject, Codable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encode(message ?? "blank", forKey: .message)
        } catch {
            print("error")
        }
    }
    
    required convenience public init(from decoder: Decoder) throws {
        // return the context from the decoder userinfo dictionary
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "GitCommit", in: managedObjectContext)
            else {
                fatalError("decode failure")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            message = try values.decode(String.self, forKey: .message)
            committer = try values.decode(Committer.self, forKey: .committer)
            
        } catch {
            print ("error")
        }
    }
    
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case committer = "committer"
        
    }
    
}
