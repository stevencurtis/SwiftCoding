//
//  Committer+CoreDataProperties.swift
//  CoreDataPredicate
//
//  Created by Steven Curtis on 18/06/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//
//

import Foundation
import CoreData


extension Committer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Committer> {
        return NSFetchRequest<Committer>(entityName: "Committer")
    }

    @NSManaged public var date: Date?
    @NSManaged public var name: String?

}
