//
//  UIPageControllerWithAnimationUITests.swift
//  UIPageControllerWithAnimationUITests
//
//  Created by Steven Curtis on 27/05/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import XCTest

class UIPageControllerWithAnimationUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    func testSwipes() {
        
        let app = XCUIApplication()
        app.otherElements.containing(.pageIndicator, identifier:"page 1 of 4").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.swipeLeft()
        
        let element = app.otherElements.containing(.pageIndicator, identifier:"page 2 of 4").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.swipeLeft()
        
        XCTAssert(app.staticTexts["This should be a fun exercise rather than seen as a test"].exists)
    }


    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let pageIndicator = app.pageIndicators.element(boundBy: 0)
        pageIndicator.coordinate(withNormalizedOffset: CGVector(dx: 0.9, dy: 0.2)).tap()
        XCTAssert(app.staticTexts["Learn"].waitForExistence(timeout: 2))
    }
    
    
    class PressNextThenSwipe {
        func swipeLeft(element: XCUIElement ) {
            element.swipeLeft()
        }
        func swipeRight(element: XCUIElement ) {
            element.swipeRight()
        }
    }


}
