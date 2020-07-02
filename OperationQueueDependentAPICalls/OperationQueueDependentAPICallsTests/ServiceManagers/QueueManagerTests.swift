//
//  QueueManagerTests.swift
//  OperationQueueDependentAPICallsTests
//
//  Created by Steven Curtis on 11/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
@testable import OperationQueueDependentAPICalls

class QueueManagerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        queueManager = QueueManager()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    var queueManager :QueueManager?

    
    func testenqueue() {
        let expectation = XCTestExpectation(description: #function)
        
        let operationMock = OperationMock()
        
        operationMock.completionHandler = {
            expectation.fulfill()
        }
        
        queueManager?.enqueue(operationMock)
        wait(for: [expectation], timeout: 3.0)
    }
    
    
    func testenqueuemultiple() {
        let expectation = XCTestExpectation(description: #function)
        var resultArray: [OperationMock] = []
        let operationMockOne = OperationMock()
        operationMockOne.delay = 1.0
        
        operationMockOne.completionHandler = {
            resultArray.append(operationMockOne)
        }
        
        let operationMockTwo = OperationMock()
        operationMockTwo.delay = 2.0
        
        operationMockTwo.completionHandler = {
            resultArray.append(operationMockTwo)
        }
        
        let operationMockThree = OperationMock()
        operationMockThree.delay = 3.0
        
        operationMockThree.completionHandler = {
        XCTAssertEqual(resultArray, [operationMockOne, operationMockTwo])
        expectation.fulfill()
        }
        
        queueManager?.enqueue(operationMockOne)
        queueManager?.enqueue(operationMockTwo)
        queueManager?.enqueue(operationMockThree)

        wait(for: [expectation], timeout: 4.0)
    }
    
    
    func testaddOperation() {
        let expectation = XCTestExpectation(description: #function)
        
        let operationMock = OperationMock()
        
        operationMock.completionHandler = {
            expectation.fulfill()
        }
        
        queueManager?.addOperations([operationMock])
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testaddOperations() {
        let expectation = XCTestExpectation(description: #function)
        var resultArray: [OperationMock] = []
        let operationMockOne = OperationMock()
        operationMockOne.delay = 1.0
        
        operationMockOne.completionHandler = {
            resultArray.append(operationMockOne)
        }
        
        let operationMockTwo = OperationMock()
        operationMockTwo.delay = 2.0
        
        operationMockTwo.completionHandler = {
            resultArray.append(operationMockTwo)
        }
        
        let operationMockThree = OperationMock()
        operationMockThree.delay = 3.0
        
        operationMockThree.completionHandler = {
        XCTAssertEqual(resultArray, [operationMockOne, operationMockTwo])
        expectation.fulfill()
        }
        
        queueManager?.addOperations([operationMockOne, operationMockTwo, operationMockThree])

        wait(for: [expectation], timeout: 4.0)
    }
    
    
}
