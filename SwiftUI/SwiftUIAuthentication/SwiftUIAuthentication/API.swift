//
//  API.swift
//  SwiftUIAuthentication
//
//  Created by Steven Curtis on 19/11/2020.
//

import Foundation

enum API {
    case login
    case posts
    
    var url: URL {
        var component = URLComponents()
        switch self {
        case .login:
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
        case .posts:
            return "/posts"
        }
    }
}
