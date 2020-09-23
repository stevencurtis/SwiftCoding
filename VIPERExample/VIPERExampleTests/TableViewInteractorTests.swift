//
//  TableViewInteractorTests.swift
//  VIPERExampleTests
//
//  Created by Steven Curtis on 23/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
import NetworkLibrary
@testable import VIPERExample

class TableViewInteractorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    let mockPresenter: TableViewPresenterProtocol = MockTableViewPresenter()
    
    func testInteractor() {
        let expectation = XCTestExpectation(description: #function)
        let networkManager = MockNetworkManager(session: URLSession.shared)
        networkManager.outputData = photosString.data(using: .utf8)
        let interactor = TableViewInteractor(networkManager: networkManager)
        interactor.presenter = mockPresenter
        (mockPresenter as? MockTableViewPresenter)?.didfetch = {
            expectation.fulfill()
        }
        interactor.getData()
        wait(for: [expectation], timeout: 2.0)
    }

}
