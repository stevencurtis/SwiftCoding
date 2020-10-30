//
//  MockDataManager.swift
//  SwiftUICoreDataTests
//
//  Created by Steven Curtis on 15/10/2020.
//

import Foundation
import CoreData
@testable import SwiftUICoreData

class MockDataManager: DataManagerProtocol {
    func save(date: Date, completion: @escaping (() -> Void)) {
        saved = true
    }
    
    func getManagedObjects() throws -> [NSManagedObject] {
        if willReturn {
            let date = Date(timeIntervalSince1970: 1602773147)
            let timeObject = NSEntityDescription.insertNewObject(forEntityName: "CountryPairCD", into: managedObjectContext)
            timeObject.setValue(date, forKey: Constants.timeAttribute)
            pairs.append(timeObject)
            return pairs
        } else {
            return []
        }
    }
    
    
    var willReturn: Bool = true
    var saved: Bool = false

    func delete(baseCurrencyCode: String, comparisonCurrencyCode: String, completion: (() -> Void)?) {}


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
