//
//  Publisher+withUnretained.swift
//  ComponentsViewModel
//
//  Created by Steven Curtis on 24/07/2021.
//

import Combine
import Foundation

extension Publisher {
    func withUnretained<Object: AnyObject>(_ obj: Object) -> AnyPublisher<(Object, Output), Error> {
        return tryMap { [weak obj] element -> (Object, Output) in
            guard let obj = obj else { throw UnretainedError.failedRetaining }
            return (obj, element)
        }
        .eraseToAnyPublisher()
    }
}

enum UnretainedError: Swift.Error {
    case failedRetaining
}
