//
//  Cache.swift
//  CustomTabBarSimpleAPI
//
//  Created by Steven Curtis on 02/04/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation

class Cache {
    private static var sharedCache: NSCache<AnyObject, AnyObject>?
    static public func getCache () -> NSCache<AnyObject, AnyObject> {
        if sharedCache == nil {
            self.sharedCache = NSCache()
        }
        return sharedCache!
    }
}
