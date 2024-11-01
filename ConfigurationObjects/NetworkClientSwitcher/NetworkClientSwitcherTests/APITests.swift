@testable import NetworkClientSwitcher
import XCTest

final class APITests: XCTestCase {
    func testUsers() async {
        XCTAssertEqual(API.users.url, URL(string: "https://jsonplaceholder.typicode.com/users"))
    }
}
