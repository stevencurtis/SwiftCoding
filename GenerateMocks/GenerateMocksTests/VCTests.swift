//
//  VCTests.swift
//  GenerateMocksTests
//
//  Created by Steven Curtis on 28/12/2020.
//

import XCTest
@testable import GenerateMocks

class VCTests: XCTestCase {
    var viewController: ViewController?
    var greeting: GreetingProtocolMock!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        greeting = .init()
        greeting.sayHelloReturnValue = "test"
        viewController = .init(greeting: greeting)
    }

    func testLab() {
        viewController?.viewDidLoad()
        XCTAssertEqual(viewController!.basicLabel.text, "test")
    }
}
