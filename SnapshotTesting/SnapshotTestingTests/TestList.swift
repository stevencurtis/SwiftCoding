//
//  TestList.swift
//  SnapshotTestingTests
//
//  Created by Steven Curtis on 24/09/2020.
//

import XCTest
import FBSnapshotTestCase
import NetworkLibrary
@testable import SnapshotTesting

class TestList: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        recordMode = false
    }

    func testList() {
        let networkManager = MockNetworkManager(session: URLSession.shared)
        networkManager.outputData = photoString.data(using: .utf8)
            // photoStringAlternative.data(using: .utf8)
            // emptyString.data(using: .utf8)
        let listVM = ListViewModel(manager: networkManager)
        let list = ListViewController(viewModel: listVM)
        FBSnapshotVerifyViewController(list)
    }

}
