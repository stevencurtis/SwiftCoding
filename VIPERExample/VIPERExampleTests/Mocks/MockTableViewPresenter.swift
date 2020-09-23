//
//  MockTableViewPresenter.swift
//  VIPERExampleTests
//
//  Created by Steven Curtis on 23/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
@testable import VIPERExample

class MockTableViewPresenter: TableViewPresenterProtocol {
    var didfetch: (()->())?
    func loadData() {}
    
    func dataDidFetch(photos: [Photo]) {
        if let didFetch = didfetch {
            didFetch()
        }
    }
    
    func moveToDetail(indexPath: IndexPath) { }
}
