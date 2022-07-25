//
//  ListViewModelTests.swift
//  SnapshotTestingTests
//
//  Created by Steven Curtis on 24/09/2020.
//

import XCTest
@testable import SnapshotTesting
import NetworkLibrary


class ListViewModelTests: XCTestCase {

    let photo = Photo(albumId: 1, id: 1, title: "accusamus beatae ad facilis cum similique qui sunt", url: "https://via.placeholder.com/600/92c952", thumbnailUrl: "https://via.placeholder.com/150/92c952")
    
    func testFetch() {
        let expect = XCTestExpectation(description: "")
        
        let mockNetworkManager = MockNetworkManager(session: URLSession.shared)
        mockNetworkManager.outputData = photoString.data(using: .utf8)

        let vm = ListViewModel(manager: mockNetworkManager)
        vm.update = {
            XCTAssertEqual(vm.photos, [self.photo])
            expect.fulfill()
        }
        
        vm.fetchPhotos()
        
        wait(for: [expect], timeout: 2.0)
    }

}
