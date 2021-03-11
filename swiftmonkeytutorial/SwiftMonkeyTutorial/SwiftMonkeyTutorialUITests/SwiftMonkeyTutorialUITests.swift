//
//  SwiftMonkeyTutorialUITests.swift
//  SwiftMonkeyTutorialUITests
//
//  Created by Steven Curtis on 13/07/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import XCTest
import SwiftMonkey


class SwiftMonkeyTutorialUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
//        XCUIApplication().launch()
        
        let app = XCUIApplication()
        app.launchEnvironment = ["testenv" : "testenvValue"]
        app.launchArguments = ["--MonkeyPaws"]
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    func testMonkey() {
        let application = XCUIApplication()
        
        // Workaround for bug in Xcode 7.3. Snapshots are not properly updated
        // when you initially call app.frame, resulting in a zero-sized rect.
        // Doing a random query seems to update everything properly.
        // TODO: Remove this when the Xcode bug is fixed!
        _ = application.descendants(matching: .any).element(boundBy: 0).frame
        
        // Initialise the monkey tester with the current device
        // frame. Giving an explicit seed will make it generate
        // the same sequence of events on each run, and leaving it
        // out will generate a new sequence on each run.
        let monkey = Monkey(frame: application.frame)
        //let monkey = Monkey(seed: 123, frame: application.frame)
        
        // Add actions for the monkey to perform. We just use a
        // default set of actions for this, which is usually enough.
        // Use either one of these, but maybe not both.
        // XCTest private actions seem to work better at the moment.
        // UIAutomation actions seem to work only on the simulator.
//        monkey.addDefaultXCTestPrivateActions()
        monkey.addDefaultUIAutomationActions()
        
        // Occasionally, use the regular XCTest functionality
        // to check if an alert is shown, and click a random
        // button on it.
                monkey.addXCTestTapAlertAction(interval: 100, application: application)
        
        // Run the monkey test indefinitely.
        monkey.monkeyAround()
    }


}
