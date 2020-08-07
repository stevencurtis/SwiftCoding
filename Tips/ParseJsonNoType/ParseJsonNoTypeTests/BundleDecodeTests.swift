//
//  BundleDecodeTests.swift
//  ParseJsonNoTypeTests
//
//  Created by Steven Curtis on 06/08/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
@testable import ParseJsonNoType


class BundleDecodeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testingDecodeMissingFile() {
        // Times.json is in the main bundle, not in the test bundle
        XCTAssertThrowsError(try Bundle(for: type(of: self)).decode(TimeModel.self, from: "Times.json"))
    }
    


}
