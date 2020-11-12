//
//  TwoWayBindingTests.swift
//  TwoWayBindingTests
//
//  Created by Steven Curtis on 04/11/2020.
//

import XCTest
@testable import TwoWayBinding

class TwoWayBindingTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testObservableString() {
        let text = Observable("tests")
        let test = TestClass()
        
        text.observe(on: test, completion: {result in
            let res = result
            print (res)
            print (test.str)
            XCTAssertEqual(1, 1)
        })
    }
    
    func testObservableStringChanges() {
        let expectation = XCTestExpectation(description: #function)
        let text = Observable("tests")
        let test = TestClass()
        var results: [String] = []
        text.observe(on: test, completion: {result in
            results.append(result)
            if results.count == 2 {
                XCTAssertEqual(results, ["tests", "changed"])
                expectation.fulfill()
            }
        })
        text.value = "changed"
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testObservableMultipleStrings() {
        let expectation = XCTestExpectation(description: #function)
        let text = Observable("tests")
        let second = Observable("second")
        let dg = DispatchGroup()
        dg.enter()
        dg.enter()
        
        let test = TestClass()
        var results: [String] = []
        text.observe(on: test, completion: {result in
            results.append(result)
            dg.leave()
        })
        
        second.observe(on: test, completion: {result in
            results.append(result)
            dg.leave()
        })
        
        dg.notify(queue: .main, execute: {
            XCTAssertEqual(results, ["tests", "second"])
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testBinding() {
        let expectation = XCTestExpectation(description: #function)
        let text = Observable("tests")
        let testTF = TestTF()
        var results: [String] = []

        testTF.closure = {str in
            print ("str",str)
            results.append(str)
            if results.count == 2 {
                XCTAssertEqual(results, ["tests", "test"])
                expectation.fulfill()
            }
        }
        testTF.bind(with: text)
        text.value = "test"
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testMakeBinding() {
        let expectation = XCTestExpectation(description: #function)
        let text = MakeBindable("tests")
        let testTF = TestTF()
        var results: [String] = []

        testTF.closure = {str in
            results.append(str)
            if results.count == 2 {
                XCTAssertEqual(results, ["tests", "test"])
                expectation.fulfill()
            }
        }
        text.bind(\String.self, to: testTF, \.text)

        text.update(with: "test")
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testTFChange() {
        let text = MakeBindable("tests")
        let testTF = TestTF()
        text.bind(\String.self, to: testTF, \.text)
        testTF.text = "test"
        testTF.sendActions(for: .editingChanged)
        XCTAssertEqual(text.currentValue(), "test")
    }
}
