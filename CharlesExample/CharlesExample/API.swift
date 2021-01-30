//
//  API.swift
//  CharlesExample
//
//  Created by Steven Curtis on 19/12/2020.
//

import UIKit

enum API {
    case login
    case posts
    case missing
    
    var url: URL {
        var component = URLComponents()
        switch self {
        case .login:
            component.scheme = "https"
            component.host = "reqres.in"
            component.path = path
        case .missing:
            component.scheme = "https"
            component.host = "reqres.in"
            component.path = path
        case .posts:
            component.scheme = "https"
            component.host = "jsonplaceholder.typicode.com"
            component.path = path
        }
        return component.url!
    }
}

extension API {
    fileprivate var path: String {
        switch self {
        case .login:
            return "/api/login"
        case .missing:
            return "/missing"
        case .posts:
            return "/posts"
        }
    }
}
