//
//  MockTableViewInteractor.swift
//  VIPERExampleTests
//
//  Created by Steven Curtis on 23/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
@testable import VIPERExample

class MockTableViewInteractor: TableViewInteractorProtocol {
    var presenter: TableViewPresenterProtocol?
    
    var dataRequested = false
    func getData() {
        dataRequested = true
    }
}
