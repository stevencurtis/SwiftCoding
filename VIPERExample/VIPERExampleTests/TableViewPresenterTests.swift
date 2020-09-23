//
//  TableViewPresenterTests.swift
//  VIPERExampleTests
//
//  Created by Steven Curtis on 23/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
@testable import VIPERExample

class TableViewPresenterTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    let photo = Photo(albumId: 1, id: 1, title: "test", url: "testurl", thumbnailUrl: "thumbURL")
    
    func testPresenter() {
        let presenter = TableViewPresenter()
        let interactor: TableViewInteractorProtocol = MockTableViewInteractor()
        presenter.interactor = interactor
        presenter.loadData()
        XCTAssertEqual( (interactor as! MockTableViewInteractor).dataRequested, true)
    }

        func testPresenterDidFetch() {
            let presenter = TableViewPresenter()
            let interactor: TableViewInteractorProtocol = MockTableViewInteractor()
            presenter.interactor = interactor
            presenter.dataDidFetch(photos: [photo])
            XCTAssertEqual(presenter.photos, [photo])
        }
    
    func testMove() {
        let presenter = TableViewPresenter()
        let wireframe: TableViewWireframeProtocol = MockTableViewWireframe()
        presenter.photos = [photo]
        let indexPath = IndexPath(row: 0, section: 0)
        presenter.wireframe = wireframe
        presenter.view = MockView()
        presenter.moveToDetail(indexPath: indexPath)
        XCTAssertEqual((wireframe as! MockTableViewWireframe).requestMoveToURL, nil)
    }

}
