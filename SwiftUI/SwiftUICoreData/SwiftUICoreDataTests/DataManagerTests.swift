//
//  DataManagerTests.swift
//  SwiftUICoreDataTests
//
//  Created by Steven Curtis on 15/10/2020.
//

import XCTest
import CoreData
@testable import SwiftUICoreData

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
    
    func testGetManagedObjectError() {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = storeCordinator
        let entity = NSEntityDescription.entity(forEntityName: Constants.entityName, in: managedObjectContext)!
        let CDM = DataManager(objectContext: managedObjectContext, entity: entity)
        XCTAssertThrowsError(try CDM.getManagedObjects() )
    }

    func testSaveObject() {
        let expectation = XCTestExpectation(description: #function)
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = storeCordinator
        let entity = NSEntityDescription.entity(forEntityName: Constants.entityName, in: managedObjectContext)!
        let CDM = DataManager(objectContext: managedObjectContext, entity: entity)
        let date = Date(timeIntervalSince1970: 1602773585)
        CDM.save(date: date, completion: {
            let entitites = try! CDM.getManagedObjects()
            XCTAssertEqual(entitites.count, 1)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 3.0)
    }
}
