//
//  MockTableViewWireframe.swift
//  VIPERExampleTests
//
//  Created by Steven Curtis on 23/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit
@testable import VIPERExample


class MockTableViewWireframe: TableViewWireframeProtocol {
    var moveToDetail: URL?
    func moveToDetail(view: TableViewControllerProtocol, withURL url: URL) {
         moveToDetail = url
    }
    
    var requestMoveToURL: URL?
    func moveToDetail(view: UIViewController, withURL url: URL) {
        requestMoveToURL = url
    }
}
