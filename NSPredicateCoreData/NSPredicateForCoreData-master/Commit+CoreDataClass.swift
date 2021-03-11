//
//  Commit+CoreDataClass.swift
//  CoreDataPredicate
//
//  Created by Steven Curtis on 18/06/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Commit)
public class Commit: NSManagedObject, Codable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encode(sha ?? "blank", forKey: .sha)
        } catch {
            print("error")
        }
    }
    
    required convenience public init(from decoder: Decoder) throws {
        // return the context from the decoder userinfo dictionary
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Commit", in: managedObjectContext)
            else {
                fatalError("decode failure")
        }
        // Super init of the NSManagedObject
        self.init(entity: entity, insertInto: managedObjectContext)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            sha = try values.decode(String.self, forKey: .sha)
            url = try values.decode(String.self, forKey: .url)
            html_url = try values.decode(String.self, forKey: .html_url)
            gitcommit = try values.decode(GitCommit.self, forKey: .gitcommit)
        } catch {
            print ("error")
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case sha = "sha"
        case gitcommit = "commit"
        case url = "url"
        case html_url = "html_url"
    }
}
