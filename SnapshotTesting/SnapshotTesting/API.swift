//
//  API.swift
//  SnapshotTesting
//
//  Created by Steven Curtis on 24/09/2020.
//

import Foundation

// https://jsonplaceholder.typicode.com/photos

enum API {
    case photos
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "jsonplaceholder.typicode.com"
        components.path = "/photos"
        return components.url
    }
    
}
