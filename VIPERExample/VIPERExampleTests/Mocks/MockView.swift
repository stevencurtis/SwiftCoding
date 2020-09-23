//
//  MockView.swift
//  VIPERExampleTests
//
//  Created by Steven Curtis on 23/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit
@testable import VIPERExample

class MockView: TableViewControllerProtocol {
    var didRefresh: (()->())?
    func refresh() {
        if let didRefresh = didRefresh {
            didRefresh()
        }
    }
    
    var navigationController: UINavigationController?
}
