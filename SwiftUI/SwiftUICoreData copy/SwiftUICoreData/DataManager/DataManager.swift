//
//  DataManager.swift
//  SwiftUICoreData
//
//  Created by Steven Curtis on 09/10/2020.
//

import UIKit
import CoreData

public protocol DataManagerProtocol {
    func getManagedObjects() throws -> [NSManagedObject]
    func save(name: String, color: UIColor, completion:  @escaping ( ()-> Void) )
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
        
//        let pc = PersistenceController()
//        pc.container.viewContext
//        pc.container.managedObjectModel
        
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
    
    func save(name: String, color: UIColor, completion: @escaping  ( ()-> Void) ) {
        managedObjectContext.perform {
            
            // Only add each entity a single time
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.entityName)
            fetchRequest.predicate = NSPredicate(format: "name = '\(name)'", argumentArray: [Constants.nameAttribute])

            if let res = try? self.managedObjectContext.fetch(fetchRequest) {
                if res.count > 0 {
                    completion()
                    return
                }
            }
            
            // Add the single item
            let taskObject = NSManagedObject(entity: self.entity, insertInto: self.managedObjectContext)
            taskObject.setValue(name, forKeyPath: Constants.nameAttribute)
            taskObject.setValue(color, forKeyPath: Constants.colorAttribute)

            self.saveContext(completion: {
                completion()
            })
        }
    }
    
    
    func save(baseCurrencyCode: String, comparisonCurrencyCode: String, completion: (() -> Void)? = nil) {
        managedObjectContext.perform {
//            let taskObject = NSManagedObject(entity: self.entity, insertInto: self.managedObjectContext)
//            taskObject.setValue(baseCurrencyCode, forKeyPath: Constants.baseAttribute)
//            taskObject.setValue(comparisonCurrencyCode, forKeyPath: Constants.comparisonAttribute)
//            self.saveContext(completion: completion ?? {})
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

