//
//  InformationCD+CoreDataClass.swift
//  CoreDataTransformable
//
//  Created by Steven Curtis on 08/10/2020.
//
//

import Foundation
import CoreData
import UIKit

public class InformationCD: NSManagedObject, NSSecureCoding {
    public static var supportsSecureCoding: Bool = true
    
    public func encode(with coder: NSCoder) {
        print ("A")
    }

    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    public required init?(coder: NSCoder) {
        super.init(entity: DataManager().getEntityManagedObject().0, insertInto: DataManager().getEntityManagedObject().1)
    }
}

