//
//  SQLiteManagerTests.swift
//  SQLiteManagerTests
//
//  Created by Steven Curtis on 15/10/2020.
//

import XCTest
import SQLite3
@testable import SQLiteManager

class SQLiteManagerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testOpenDB() {
        let expectation = XCTestExpectation(description: #function)
        let mgr = SQLiteManager("testDB")
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
    
//    func testReadDB() {
//        let expectation = XCTestExpectation(description: #function)
//        let mgr = SQLiteManager("testDB")
//
//        mgr.open(withdbpathfunc: TestHelpers().testPath, withCompletionHandler: { result in
//            switch result {
//            case .failure(let error):
//                print(error)
//            case .success(let success):
//                let result = mgr.readDB(from: "mytable", success!)
//                XCTAssertEqual(result, [["1", "Apple"], ["2", "Bread"], ["3", "Fries"]])
//                expectation.fulfill()
//            }
//        })
//        wait(for: [expectation], timeout: 3.0)
//    }
    
//    func testDeleteDB() {
//        let expectation = XCTestExpectation(description: #function)
//        let mgr = SQLiteManager("testDB")
//        mgr.open(withdbpathfunc: TestHelpers().testPath, withCompletionHandler: { result in
//            switch result {
//            case .failure(let error):
//                print(error)
//            case .success(let success):
//                try! mgr.delete(table: "mytable", deleteValues: PairedVals(column: "ID", data: .integer(2)), success!, completion: {
//                    let result = TestHelpers().readFromTable(table: "mytable", success!)
//                    XCTAssertEqual(result, [["1", "Apple"], ["3", "Fries"]])
//                    expectation.fulfill()
//                }
//                )
//            }
//        })
//        wait(for: [expectation], timeout: 3.0)
//    }
    
//    func testReadDBTwo() {
//        let expectation = XCTestExpectation(description: #function)
//        let mgr = SQLiteManager("testDB")
//
//        mgr.open(withdbpathfunc: TestHelpers().testPath, withCompletionHandler: { result in
//            switch result {
//            case .failure(let error):
//                print(error)
//            case .success(let success):
//                let result = mgr.readDB(from: "mytable", success!)
//                XCTAssertEqual(result, [["1", "Apple"], ["2", "Bread"], ["3", "Fries"]])
//                expectation.fulfill()
//            }
//        })
//        wait(for: [expectation], timeout: 3.0)
//    }
//    
}
