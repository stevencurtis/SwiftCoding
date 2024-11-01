@testable import NetworkClientSwitcher
import XCTest

final class UserTests: XCTestCase {
    func testUserInitializationFromUserDTO() {
        let userDTO = UserDTO(id: 0, username: "TestUser")
        let user = User(user: userDTO)
        XCTAssertEqual(user.username, userDTO.username)
    }
}
