//
//  CoreDataManager.swift
//  hiring-mobile-test
//
//  Created by Steven Curtis on 25/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit
import CoreData
import UIKit

public protocol DataManagerProtocol {
    func getManagedObjects() throws -> [NSManagedObject]
    func save(data: Data, completion: @escaping ( ()-> Void) )
    init()
}

final class DataManager: DataManagerProtocol {
    private var pairs = [NSManagedObject]()
    private var managedObjectContext: NSManagedObjectContext! = nil
    private var entity: NSEntityDescription! = nil
    
    init (objectContext: NSManagedObjectContext, entity: NSEntityDescription) {
        self.managedObjectContext = objectContext
        self.entity = entity
    }
    
    required init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        managedObjectContext = appDelegate.persistentContainer.viewContext
        managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        if let entityDescription = NSEntityDescription.entity(
            forEntityName: Constants.entityName,
            in: managedObjectContext) {
            entity = entityDescription
        }
    }

    func getManagedObjects() throws -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Constants.entityName)
        do {
            pairs = try managedObjectContext.fetch(fetchRequest)
        } catch let error as NSError {
            throw ErrorModel(errorDescription: "Core Data Error. Could not fetch. \(error), \(error.userInfo)")
        }
        if pairs.isEmpty {throw ErrorModel(errorDescription: "No Pairs")}
        return pairs
    }
    
    func getEntityManagedObject() -> (NSEntityDescription, NSManagedObjectContext) {
        return (self.entity, self.managedObjectContext)
    }
    
    func save(data: Data, completion: @escaping ( ()-> Void) ) {
        managedObjectContext.perform {
            let imageObject = NSManagedObject(entity: self.entity, insertInto: self.managedObjectContext)
            imageObject.setValue(data, forKey: Constants.imageAttribute)
            
            self.saveContext(completion: {
                completion()
            })
        }
    }

    
    func saveContext(completion: @escaping () -> Void) {
        managedObjectContext.perform {
            do {
                try self.managedObjectContext.save()
                completion()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
}
