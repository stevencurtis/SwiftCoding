//
//  UserRetrievalOperation.swift
//  OperationQueueDependentAPICalls
//
//  Created by Steven Curtis on 11/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

class UserRetrievalOperation<T: HTTPManagerProtocol>: NetworkOperation {

    var dataFetched: Data?
    var url: URL?
    var error: Error?

    var httpManager: T?

    init(url: URL?, httpManager: T) {
        self.url = url
        self.httpManager = httpManager
    }
       
    override func main() {
        guard let url = url else {return}
        httpManager?.get(url: url, completionBlock: { data in
            switch data {
            case .failure(let error):
                self.error = error
            case .success(let successdata):
                self.dataFetched = successdata
                self.complete(result: data)
            }
        })
    }
}
