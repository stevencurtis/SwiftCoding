//
//  CacheManagerNSCache.swift
//  CacheResponses
//
//  Created by Steven Curtis on 15/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

final class CacheManagerNSCache: CacheManagerProtocol {
    
    private var memoryWarningObserver: NSObjectProtocol!

    private init() {
        memoryWarningObserver = NotificationCenter.default.addObserver(forName:
        UIApplication.didReceiveMemoryWarningNotification, object: nil, queue: nil) { [weak self] notification in
            self?.cache.removeAllObjects()
        }
    }
    
    // Singletons are never dealloc, but still...
    deinit {
        NotificationCenter.default.removeObserver(memoryWarningObserver!)
    }
    
    subscript(request: URLRequest) -> Data? {
        get {
            if let object = cache.object(forKey: request.description as NSString) {
                return (Data(referencing: object))
            }
            return nil
        }
        set {
            if let object = newValue {
                cache.setObject(NSData(data: object), forKey: request.description as NSString)
                
            } else {
                cache.removeObject(forKey: request.description as NSString)
            }
        }
    }
    
    private var cache: NSCache<NSString, NSData> = NSCache<NSString, NSData>()
    static var shared = CacheManagerNSCache()

    
    func fetchDataFromCache(request: URLRequest, completion: ((Data?) -> ())) {
        if let object = cache.object(forKey: request.description as NSString) {
            completion(Data(referencing: object))
        } else {
            completion(nil)
        }
    }
    
    func storeDataToCache(request: URLRequest, data: Data) {
        cache.setObject(NSData(data: data), forKey: request.description as NSString)
    }
}
