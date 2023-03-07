//
//  SQLiteMangerInjectionTests.swift
//  SQLiteManagerTests
//
//  Created by Steven Curtis on 21/10/2020.
//

import XCTest
import SQLite3
@testable import SQLiteManager

class SQLiteMangerInjectionTests: XCTestCase {

    var wrapper: MockSqlite3Wrapper!
    var mgr: SQLiteManager!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        wrapper = MockSqlite3Wrapper()
        mgr = SQLiteManager("testDB", wrapper: wrapper)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testOpenDB() {
        let expectation = XCTestExpectation(description: #function)
        mgr.open(withdbpathfunc: TestHelpers().testPath, withCompletionHandler: { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let success):
                XCTAssertNotNil(success)
                expectation.fulfill()
            }
        })
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testReadDB() {
        let expectation = XCTestExpectation(description: #function)
        mgr.open(withdbpathfunc: TestHelpers().testPath, withCompletionHandler: { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let success):
                let result = self.mgr.readDB(from: "mytable", success!)
                XCTAssertEqual(result, [["1", "Hello", "World"], ["2", "a", "b"]])
                expectation.fulfill()
            }
        })
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testInsertDB() {
        let expectation = XCTestExpectation(description: #function)
        mgr.open(withdbpathfunc: TestHelpers().testPath, withCompletionHandler: { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let success):
                try! self.mgr.insert(table: "mytable", insertValues: [PairedVals(column: "Hello", data: .text("test1")), PairedVals(column: "a", data: .text("test2")) ], success!, completion: {
                    print ( self.wrapper.whichRun.bindText )
                    XCTAssertEqual(self.wrapper.whichRun.bindText, ["test1", "test2"])
                    expectation.fulfill()
                })
            }
        })
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testUpdateDB() {
        let expectation = XCTestExpectation(description: #function)
        mgr.open(withdbpathfunc: TestHelpers().testPath, withCompletionHandler: { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let success):
                try! self.mgr.update(table: "mytable", updateValues: [PairedVals(column: "Hello", data: .text("1")), PairedVals(column: "a", data: .text("2"))], whereValues: PairedVals(column: "Hello", data: .text("42")), success!, completion: {
                    XCTAssertEqual(self.wrapper.whichRun.bindText, ["1", "2", "42"])
                    expectation.fulfill()
                })
            }
        })
        wait(for: [expectation], timeout: 3.0)
    }

    func testDeleteDB() {
        let expectation = XCTestExpectation(description: #function)
        wrapper.stepdone = true
        mgr.open(withdbpathfunc: TestHelpers().testPath, withCompletionHandler: { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let success):
                try! self.mgr.delete(table: "mytable", deleteValues: PairedVals(column: "1", data: .text("Hello")), success!, completion: {
                    XCTAssertEqual(self.wrapper.whichRun.bindText, ["Hello"])
                    expectation.fulfill()
                })
            }
        })
        wait(for: [expectation], timeout: 3.0)
    }
    
    private var createStatement: String {
        return """
      CREATE TABLE Contact(
        Id INT PRIMARY KEY NOT NULL,
        Name CHAR(255)
      );
      """
    }
    
    func testCreateDB() {
        let expectation = XCTestExpectation(description: #function)
        wrapper.stepdone = true
        mgr.clearDiskCache(databasePath: TestHelpers().testPath()!, dbname: "testDB")
        
        mgr.open(withdbpathfunc: TestHelpers().testPath, withCompletionHandler: { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let success):
                try! self.mgr.createTable(createStatement: self.createStatement)
//                try! mgr.delete(table: "mytable", deleteValues: PairedVals(column: "1", data: .text("Hello")), success!, completion: {
//                    XCTAssertEqual(wrapper.whichRun.bindText, ["Hello"])
                    expectation.fulfill()
//                })
            }
        })
        wait(for: [expectation], timeout: 3.0)
    }
    
}
