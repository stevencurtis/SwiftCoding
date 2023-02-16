//
//  DataManagerTests.swift
//  hiring-mobile-testTests
//
//  Created by Steven Curtis on 27/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
import CoreData
@testable import CoreDataTransformable

class DataManagerTests: XCTestCase {

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
    
    func testGetPairsError() {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = storeCordinator
        let entity = NSEntityDescription.entity(forEntityName: Constants.entityName, in: managedObjectContext)!
        let CDM = DataManager(objectContext: managedObjectContext, entity: entity)
        XCTAssertThrowsError(try CDM.getManagedObjects())
    }
    
    func testSavePairs() {
        let expectation = XCTestExpectation(description: #function)
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = storeCordinator
        let entity = NSEntityDescription.entity(forEntityName: Constants.entityName, in: managedObjectContext)!
        let CDM = DataManager(objectContext: managedObjectContext, entity: entity)

        CDM.save(name: "col", color: UIColor.red, completion: {
            let entitites = try! CDM.getManagedObjects()
            XCTAssertEqual(entitites.count, 1)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 3.0)
    }


}
