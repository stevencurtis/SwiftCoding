//
//  MVVMDITests.swift
//  MVVMDITests
//
//  Created by Steven Curtis on 14/10/2020.
//

import XCTest
@testable import MVVMDI
import NetworkLibrary

class MVVMDITests: XCTestCase {
    var networkManager: MockNetworkManager<URLSession>?
    var vm: ViewModel?
    var vc: ViewController?

    override func setUpWithError() throws {
        networkManager = MockNetworkManager<URLSession>(session: URLSession.shared)
        vm = MockViewModel(networkManager: networkManager!)
        vc = ViewController(viewModel: vm!)
    }

    func testRequestData() {
        let expectation = XCTestExpectation(description: #function)
        (vm as! MockViewModel).dataRequestClosure = {
             expectation.fulfill()
        }
        vc!.getData()
        wait(for: [expectation], timeout: 3.0)
    }
}
