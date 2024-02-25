@testable import NetworkClientSwitcher
import NetworkClient
import XCTest

final class APIFactoryTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    func testMakeMockNetworkClient() {
        let networkClient = APIFactory.makeDefault(with: DebugNetworkClientConfiguration())
        XCTAssertTrue(networkClient is MockNetworkClient)
    }
    
    func testMakeMainNetworkClient() {
        let networkClient = APIFactory.makeDefault(with: ReleaseNetworkClientConfiguration())
        XCTAssertTrue(networkClient is MainNetworkClient)
    }
}
