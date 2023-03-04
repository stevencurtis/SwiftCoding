//
//  ATestProjectUIFastlaneTests.swift
//  ATestProjectUIFastlaneTests
//
//  Created by Steven Curtis on 30/09/2020.
//

import XCTest

class ATestProjectUIFastlaneTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        snapshot("01InitialScreen")
        XCUIApplication()/*@START_MENU_TOKEN@*/.staticTexts["Move to next View Controller"]/*[[".buttons[\"Move to next View Controller\"].staticTexts[\"Move to next View Controller\"]",".staticTexts[\"Move to next View Controller\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        snapshot("02MainScreen")


        app.launch()
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
