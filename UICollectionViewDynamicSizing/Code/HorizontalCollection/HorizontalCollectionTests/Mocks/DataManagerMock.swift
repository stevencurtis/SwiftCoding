//
//  DataManagerMock.swift
//  HorizontalCollectionTests
//
//  Created by Steven Curtis on 07/05/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
@testable import HorizontalCollection

class DataManagerMock: DataManagerProtocol {
    
    
    var mgr: HTTPManagerMock?
    init  (_ manager: HTTPManagerMock) {
        mgr = manager
    }
    
    func fetchImageData(withURLString urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        completion(.success(Data(count: 1)))
    }
    
    
}

