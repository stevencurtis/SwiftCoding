//
//  DataManagerBuilderMock.swift
//  HorizontalCollectionTests
//
//  Created by Steven Curtis on 07/05/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
@testable import HorizontalCollection

class DataManagerBuilder: DMBuilderProtocol {
    
    static func createDataManager<T>(with urlsession: T) -> DataManagerProtocol where T : URLSessionProtocol {
        if sharedDataManager == nil {
            let manager = HTTPManagerMock()
            sharedDataManager = DataManagerMock(manager)
        }
        return sharedDataManager!
    }
    
    private static var sharedDataManager: DataManagerProtocol?
    private init() {}

}
