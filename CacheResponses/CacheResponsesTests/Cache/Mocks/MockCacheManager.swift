//
//  CacheManagerProtocol.swift
//  LastFMDemoTests
//
//  Created by Steven Curtis on 02/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
@testable import CacheResponses

class MockCacheManager: CacheManagerProtocol {
    subscript(request: URLRequest) -> Data? {
        get {
            return nil
        }
        set(newValue) {
            // fill in if required
        }
    }
    
    func fetchDataFromCache(request: URLRequest, completion: ((Data?) -> ())) {
        if willReturn {
            completion(fetchData)
        } else {
            completion(nil)
        }
    }
    
    func storeDataToCache(request: URLRequest, data: Data) {
    }
    
    var cache: [URL: Data] = [:]
    
    var fetchData: Data?
    
    var willReturn: Bool = true
    
    public static var shared: CacheManagerProtocol! = MockCacheManager()
}
