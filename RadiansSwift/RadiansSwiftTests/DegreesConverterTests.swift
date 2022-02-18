import XCTest
@testable import RadiansSwift

class DegreesConverterTests: XCTestCase {
    func testNinetyDegrees() {
        let radians = DegreesConverter.degRad(90)
        XCTAssertEqual(radians, 1.5707963267948966)
    }
    
    func testpiRadian() {
        let radians = DegreesConverter.radDeg(.pi)
        XCTAssertEqual(radians, 180)
    }
}
