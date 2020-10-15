//
//  CacheManager.swift
//  LastFMDemo
//
//  Created by Steven Curtis on 02/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

// Use a dictionary
final class CacheManager: CacheManagerProtocol {
    private var cache: [URLRequest: Data] = [:]
    
    static var shared = CacheManager()
    
    private init() {}
    
    func fetchDataFromCache(request: URLRequest, completion: ((Data?) -> ())) {
        completion(cache[request])
    }
    
    func storeDataToCache(request: URLRequest, data: Data) {
        print ("Stored to Cache")
        cache[request] = data
    }
    
    subscript(request: URLRequest) -> Data? {
         get {
             return cache[request]
         }

         set {
             if let object = newValue {
                 cache[request] = object
             } else {
                 cache[request] = nil
             }
         }
     }
}

