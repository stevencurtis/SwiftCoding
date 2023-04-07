//
//  MockDataManager.swift
//  StoringAnImageCoreDataTests
//
//  Created by Steven Curtis on 08/10/2020.
//

import Foundation
import CoreData
import UIKit
@testable import StoringAnImageCoreData

class MockDataManager: DataManagerProtocol {
    func getManagedObjects() throws -> [NSManagedObject] {
        if willReturn {
            let ent = NSEntityDescription.insertNewObject(forEntityName: Constants.entityName, into: managedObjectContext)
            ent.setValue("name", forKey: Constants.nameAttribute)
            ent.setValue(UIColor.red, forKey: Constants.colorAttribute)
            return [ent]
        } else {
            return []
        }
    }
    
    func save(name: String, color: UIColor, completion: @escaping (() -> Void)) {
        saved = true
    }
    
    
    var willReturn: Bool = true
    var saved: Bool = false


    var storeCordinator: NSPersistentStoreCoordinator!
    var managedObjectContext: NSManagedObjectContext!
    var managedObjectModel: NSManagedObjectModel!
    var store: NSPersistentStore!
    
    var pairs = [NSManagedObject]()


    required init() {
        managedObjectModel = NSManagedObjectModel.mergedModel(from: nil)
        storeCordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = storeCordinator
    }

}

