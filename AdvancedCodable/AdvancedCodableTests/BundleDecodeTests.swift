//
//  BundleDecodeTests.swift
//  lldbTests
//
//  Created by Steven Curtis on 07/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

@testable import AdvancedCodable
import XCTest

final class BundleDecodeTests: XCTestCase {

    func testingDecodeMissingFile() {
        // Times.json is in the main bundle, not in the test bundle
        XCTAssertThrowsError(try Bundle(for: type(of: self)).decode(TimeModel.self, from: "Times.json"))
    }
    
    func testingPresentFile() {
        // Times.json is in the main bundle, not in the test bundle
        let stringPath = Bundle.main.path(forResource: "Times", ofType: "json")
        XCTAssertNotNil(stringPath)
    }
    
    func testingPresentTimeStampFile() {
        // Times.json is in the main bundle, not in the test bundle
        let stringPath = Bundle.main.path(forResource: "TimesMissingTimeStamp", ofType: "json")
        XCTAssertNotNil(stringPath)
    }
    
    func testingPresentNoKeyFile() {
        // Times.json is in the main bundle, not in the test bundle
        let stringPath = Bundle.main.path(forResource: "NoKey", ofType: "json")
        XCTAssertNotNil(stringPath)
    }
    
    func testingsnakeCaseMillisecondsISO8601Date() {
        // pull Times.json from the main bundle, and compare to our pre-calculated equatable answer
        let times: [TimeModel] = try! Bundle.main.decode([TimeModel].self, from: "Times.json", with: JSONDecoder.snakeCaseMillisecondsISO8601Date)
        
        XCTAssertEqual(times.count, 2)
        XCTAssertEqual(times, testTime)
    }
}
