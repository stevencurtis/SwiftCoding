//
//  DateComponents+formattedTimeTests.swift
//  TrackerDemoTests
//
//  Created by Steven Curtis on 01/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
@testable import TrackMyMovement

class DateComponents_formattedTimeTests: XCTestCase {
    var userCalendar: Calendar!
    override func setUpWithError() throws {
        userCalendar = Calendar.current
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTime() {
        let initialDate = Date(timeIntervalSince1970: 1598972214) // Tuesday, 1 September 2020 14:56:54
        let currentDate = Date(timeIntervalSince1970: 1598973214) // Tuesday, 1 September 2020 15:13:34

        let components = userCalendar.dateComponents([.hour,.minute,.second], from: initialDate, to: currentDate)
        XCTAssertEqual(components.formattedTime, "00:16:40")
    }
    
    func testOneSecond() {
        let initialDate = Date(timeIntervalSince1970: 1598972214) // Tuesday, 1 September 2020 14:56:54
        let currentDate = Date(timeIntervalSince1970: 1598972215) // Tuesday, 1 September 2020 14:57:54

        let components = userCalendar.dateComponents([.hour,.minute,.second], from: initialDate, to: currentDate)
        
            XCTAssertEqual(components.formattedTime, "00:00:01")
        }
        
    func testSixtySeconds() {
        let initialDate = Date(timeIntervalSince1970: 1598972214) // Tuesday, 1 September 2020 14:56:54
        let currentDate = Date(timeIntervalSince1970: 1598972274) // Tuesday, 1 September 2020 14:57:54

        let components = userCalendar.dateComponents([.hour,.minute,.second], from: initialDate, to: currentDate)
        XCTAssertEqual(components.formattedTime, "00:01:00")
    }
    
    func testSixtyMinutes() {
        let initialDate = Date(timeIntervalSince1970: 1598972214) // Tuesday, 1 September 2020 14:56:54
        let currentDate = Date(timeIntervalSince1970: 1598975875) // Tuesday, 1 September 2020 15:57:55

        let components = userCalendar.dateComponents([.hour,.minute,.second], from: initialDate, to: currentDate)
        XCTAssertEqual(components.formattedTime, "01:01:01")
    }
}
