//
//  CoreDataToDoTestingTests.swift
//  CoreDataToDoTestingTests
//
//  Created by Steven Curtis on 14/06/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import XCTest
import CoreData
@testable import CoreDataToDoTesting

class CoreDataToDoTestingTests: XCTestCase {

    var storeCordinator: NSPersistentStoreCoordinator!
    var managedObjectModel: NSManagedObjectModel!
    var store: NSPersistentStore!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])
        storeCordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        do {
            try storeCordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        } catch {
            XCTFail("Failed to create a persistent store, \(error)")
        }
    }
    
    
    override func setUp() {
        super.setUp()
        managedObjectModel = NSManagedObjectModel.mergedModel(from: nil)
        storeCordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        do {
            store = try storeCordinator.addPersistentStore(
                ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        } catch {
            XCTFail("Failed to create a persistent store, \(error)")
        }
    }
    
    func testGetTasks() {
        let CDM = CoreDataManagerMock()
        let viewController = ViewControllerFactory().create(CDM)
        guard let vc = viewController else {
            return XCTFail("Could not instantiate ViewController")
        }

        vc.loadViewIfNeeded()
        vc.tableView?.reloadData()
        let actualCell = viewController?.tableView!.cellForRow(at: IndexPath(row: 0, section: 0) )
        XCTAssertEqual("Enter your task from Mock", actualCell?.textLabel?.text)
    }
    
    func testAddItem() {
        let CDM = CoreDataManagerMock()
        let viewController = ViewControllerFactory().create(CDM)
        guard let vc = viewController else {
            return XCTFail("Could not instantiate ViewController")
        }
        vc.loadViewIfNeeded()
        vc.tableView?.reloadData()
        vc.textValue(textFieldValue: "add ME!")
        let actualCell = viewController?.tableView!.cellForRow(at: IndexPath(row: 1, section: 0) )
        XCTAssertEqual("add ME!", actualCell?.textLabel?.text)
    }
    
    func testCoreDataDependency() {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = storeCordinator
        
        let entity = NSEntityDescription.entity(forEntityName: Constants.entityName, in: managedObjectContext)!
        
        let CDM = CoreDataManager(objectContext: managedObjectContext, entity: entity)
        let viewController = ViewControllerFactory().create(CDM)
        guard let vc = viewController else {
            return XCTFail("Could not instantiate ViewController")
        }
        vc.loadViewIfNeeded()
        vc.tableView?.reloadData()
        
        let actualCell = viewController?.tableView!.cellForRow(at: IndexPath(row: 0, section: 0) )
        XCTAssertEqual("Press + to enter your task", actualCell?.textLabel?.text)
    }
    
    func testGetTasksZero() {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = storeCordinator
        let entity = NSEntityDescription.entity(forEntityName: Constants.entityName, in: managedObjectContext)!
        let CDM = CoreDataManager(objectContext: managedObjectContext, entity: entity)
        XCTAssertEqual(CDM.getTasks().count, 0)
    }
    
    func testSavePairs() {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = storeCordinator
        let entity = NSEntityDescription.entity(forEntityName: Constants.entityName, in: managedObjectContext)!
        let CDM = CoreDataManager(objectContext: managedObjectContext, entity: entity)
        CDM.save(task: "mytask")
        XCTAssertEqual(CDM.getTasks().count, 1)
    }



}

