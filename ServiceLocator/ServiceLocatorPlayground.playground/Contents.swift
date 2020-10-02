import UIKit
import XCTest

class ServerA {
    func serverAFunction() -> String {
        return "Running Server A"
    }
}

class ServerB {
    func serverBFunction() -> String {
        return "Running Server B"
    }
}

class ServiceLocator {
    private lazy var reg: [String: AnyObject] = [:]

    func addService<T>(service: T) {
        let key = "\(type(of: service))"
        reg[key] = service as AnyObject
    }

    func getService<T>() -> T? {
        let key = "\(T.self)"
        return reg[key] as? T
    }
}


class LocatorTests: XCTestCase {
    var serviceLocator = ServiceLocator()
    
    override class func setUp() {}
    
    func testService1() {
        let serv = ServerA()
        serviceLocator.addService(service: serv)
        XCTAssertEqual(serv.serverAFunction(), "ServiceA")
    }
    
    func testTwoServices() {
        let serv1 = ServerA()
        serviceLocator.addService(service: serv1)
        let srvc2 = ServerB()
        serviceLocator.addService(service: srvc2)
        XCTAssertEqual(serv1.serverAFunction(), "ServiceA")
        XCTAssertEqual(srvc2.serverBFunction(), "ServiceB")
    }

}
LocatorTests.defaultTestSuite.run()
