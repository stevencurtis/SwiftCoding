//
//  CoreDataManagerMock.swift
//  CoreDataToDoTestingTests
//
//  Created by Steven Curtis on 14/06/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation
import CoreData
@testable import CoreDataToDoTesting

class CoreDataManagerMock: CoreDataManagerProtocol {
    var storeCordinator: NSPersistentStoreCoordinator!
    var managedObjectContext: NSManagedObjectContext!
    var managedObjectModel: NSManagedObjectModel!
    var store: NSPersistentStore!
    
    var tasks = [NSManagedObject]()

    required init() {
        managedObjectModel = NSManagedObjectModel.mergedModel(from: nil)
        storeCordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = storeCordinator
    }
   
    func getTasks() -> [NSManagedObject] {
        if tasks.count > 0 {
            return tasks
        }
        do {
            store = try storeCordinator.addPersistentStore(
                ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
            
            if tasks.count == 0 {
                let entityOne = NSEntityDescription.insertNewObject(forEntityName: Constants.entityName, into: managedObjectContext)
                entityOne.setValue(false, forKey: Constants.entityCompletedattribute)
                entityOne.setValue("Enter your task from Mock", forKey: Constants.entityNameAttribute)
                tasks.append(entityOne)
            }
        } catch {
            // catch failure here
        }
        return tasks
    }
    
    func save(task: String) {
        let entity = NSEntityDescription.entity(forEntityName: Constants.entityName, in: managedObjectContext)!
        let taskObject = NSManagedObject(entity: entity, insertInto: managedObjectContext)
        taskObject.setValue(false, forKey: Constants.entityCompletedattribute)
        taskObject.setValue(task, forKey: Constants.entityNameAttribute)
        tasks.append(taskObject)
    }
}
