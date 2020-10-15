//  Created by Steven Curtis

import Foundation

public protocol NetworkManagerProtocol {
    associatedtype aType
    var session: aType { get }

    func fetch(url: URL, method: HTTPMethod, headers: [String : String], token: String?, data: [String: Any]?, completionBlock: @escaping (Result<Data, Error>) -> Void)
}

extension NetworkManagerProtocol {
    func fetch(url: URL, method: HTTPMethod, headers: [String : String] = [:], token: String?, data: [String: Any]?, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        fetch(url: url, method: method, headers: headers, token: token, data: data, completionBlock: completionBlock)
    }
}
