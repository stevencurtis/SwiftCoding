//
//  Committer+CoreDataClass.swift
//  CoreDataPredicate
//
//  Created by Steven Curtis on 18/06/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Committer)
public class Committer: NSManagedObject, Decodable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        do {
            try container.encode(name ?? "" , forKey: .name)
        } catch {
            print("error")
        }
    }
    
    required convenience public init(from decoder: Decoder) throws {
        // return the context from the decoder userinfo dictionary
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Committer", in: managedObjectContext)
            else {
                fatalError("decode failure")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            name = try values.decode(String.self, forKey: .name)
            
            // retrieve the date as a String, and convert to NSDate
            let formatter = ISO8601DateFormatter()
            let localDate = try values.decode(String.self, forKey: .date)
            date = formatter.date(from: localDate) ?? Date()
        } catch {
            print ("error")
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case name = "name"
    }
    
    
}
