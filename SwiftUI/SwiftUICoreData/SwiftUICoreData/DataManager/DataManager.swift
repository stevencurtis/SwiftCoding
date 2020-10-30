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
    func save(date: Date, completion:  @escaping ( ()-> Void) )
    init()
}

struct TaskModel: Identifiable {
    var id: UUID?
}

final class DataManager: ObservableObject, DataManagerProtocol {
    @Published var objectArray = [NSManagedObject]()
    
    private var managedObjectContext: NSManagedObjectContext! = nil
    private var entity: NSEntityDescription! = nil
    
    init (objectContext: NSManagedObjectContext, entity: NSEntityDescription) {
        self.managedObjectContext = objectContext
        self.entity = entity
        let objects = try? getManagedObjects()
        objectArray = objects ?? []
    }
    
    required init() {
        let pc = PersistenceController()
        managedObjectContext = pc.container.viewContext
        managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        let objects = try? getManagedObjects()
        objectArray = objects ?? []
        
        
        if let entityDescription = NSEntityDescription.entity(
            forEntityName: Constants.entityName,
            in: managedObjectContext) {
            entity = entityDescription
        }
    }
    
    func delete(object: NSManagedObject, completion: (() -> Void)? = nil) {
        for obj in objectArray {
            if obj.value(forKey: Constants.timeAttribute) as? Date == object.value(forKey: Constants.timeAttribute) as? Date {
                self.managedObjectContext.delete(object)
                self.saveContext{
                    print ("deleted")
                    let objects = try? self.getManagedObjects()
                    self.objectArray = objects ?? []
                }
            }
        }
    }
    
    func getManagedObjects() throws -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Constants.entityName)
        do {
            objectArray = try managedObjectContext.fetch(fetchRequest)
        } catch let error as NSError {
            throw ErrorModel(errorDescription: "Core Data Error. Could not fetch. \(error), \(error.userInfo)")
        }
        if objectArray.isEmpty {throw ErrorModel(errorDescription: "No Managed Objects")}
        return objectArray
    }
    
    
    func getEntityManagedObject() -> (NSEntityDescription, NSManagedObjectContext) {
        return (self.entity, self.managedObjectContext)
    }
    
    func save(date: Date, completion: @escaping  ( ()-> Void) ) {
        managedObjectContext.perform {
            // Add the single item
            let taskObject = NSManagedObject(entity: self.entity, insertInto: self.managedObjectContext)
            taskObject.setValue(date, forKeyPath: Constants.timeAttribute)            
            self.objectArray.append(taskObject)
            
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
