//
//  HTTPManagerProtocol.swift
//  BasicHTTPManager
//
//  Created by Steven Curtis on 03/04/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
import Combine

protocol HTTPManagerProtocol {
    associatedtype aType
    var session: aType { get }
    init(session: aType)
    
    func post<T: Decodable>(
        url: URL,
        headers: [String : String],
        data: Data
    )
        -> AnyPublisher<T, Error>
}
