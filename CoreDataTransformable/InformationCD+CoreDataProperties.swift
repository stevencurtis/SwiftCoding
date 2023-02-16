//
//  InformationCD+CoreDataProperties.swift
//  CoreDataTransformable
//
//  Created by Steven Curtis on 08/10/2020.
//
//

import Foundation
import CoreData
import UIKit


extension InformationCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InformationCD> {
        return NSFetchRequest<InformationCD>(entityName: "InformationCD")
    }

    @NSManaged public var colour: UIColor?
    @NSManaged public var name: String?

}

extension InformationCD : Identifiable {

}
