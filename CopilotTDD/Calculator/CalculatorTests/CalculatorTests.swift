//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Steven Curtis on 19/02/2023.
//

import XCTest
@testable import Calculator

final class CalculatorTests: XCTestCase {

    func testPushOperation() {
        let calc = Calculator()
        let result = calc.pushOperand(1)
        XCTAssertEqual(result, 1)
    }
    
    func testAddOperation() {
        let calc = Calculator()
        let result = calc.performOperation("+")
        XCTAssertEqual(result, nil)
    }
        
    func testAddOperationSum() {
        let calc = Calculator()
        let _ = calc.pushOperand(1)
        let _ = calc.performOperation("+")
        let result = calc.pushOperand(2)
        XCTAssertEqual(result, 3)
    }
}
