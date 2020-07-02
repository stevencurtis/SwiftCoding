//
//  Constants.swift
//  OperationQueueDependentAPICalls
//
//  Created by Steven Curtis on 11/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation


enum OQError: Error {
    case runtimeError(String)
}

// A better method to create URLS: https://medium.com/@stevenpcurtis.sc/building-urls-in-swift-51f21240c537
struct Constants {
    static let baseURL = "https://reqres.in/api/users"
}

// we will append the elements to make
// "https://reqres.in/api/users/2"
// and
// "https://reqres.in/api/users?page=2"
