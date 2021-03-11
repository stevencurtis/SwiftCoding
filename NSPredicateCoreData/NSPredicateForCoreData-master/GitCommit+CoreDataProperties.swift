//
//  GitCommit+CoreDataProperties.swift
//  CoreDataPredicate
//
//  Created by Steven Curtis on 18/06/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//
//

import Foundation
import CoreData


extension GitCommit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GitCommit> {
        return NSFetchRequest<GitCommit>(entityName: "GitCommit")
    }

    @NSManaged public var message: String?
    @NSManaged public var committer: Committer?

}
