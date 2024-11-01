import XCTest

final class NetworkClientSwitcherUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments = ["-UITests"]
        app.launch()
    }

    func testUserListLoads() throws {
        let app = XCUIApplication()
        let userCellOne = app.staticTexts["Username One"]
        XCTAssertTrue(userCellOne.exists)
        let userCellTwo = app.staticTexts["Username Two"]
        XCTAssertTrue(userCellTwo.exists)
    }
}
