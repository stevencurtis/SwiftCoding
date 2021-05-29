import XCTest

protocol ReturnRequest {
    func request() -> String
}

class Network: ReturnRequest {
    func request() -> String {
        return "Network request"
    }
}

class Database {
    func fetch() -> String {
        return "Database request"
    }
}

//extension Database: ReturnRequest {
//    func request() -> String {
//        return fetch()
//    }
//}

class DatabaseAdaptor: ReturnRequest {
    private let database = Database()
    func request() -> String {
        return database.fetch()
    }
}

class AdapterTests: XCTestCase {
    var network: ReturnRequest?
    var database: ReturnRequest?
    
    override func setUpWithError() throws {
        network = Network()
        database = DatabaseAdaptor()

//        database = Database()
    }

    func testNetworkRequest() {
        XCTAssertEqual(network?.request(), "Network request")
    }
    
    func testDatabaseRequest() {
        XCTAssertEqual(database?.request(), "Database request")
    }
}

AdapterTests.defaultTestSuite.run()

