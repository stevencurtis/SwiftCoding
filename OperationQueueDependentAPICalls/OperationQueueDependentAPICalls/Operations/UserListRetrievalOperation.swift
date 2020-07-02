//
//  UserListRetrievalOperation.swift
//  OperationQueueDependentAPICalls
//
//  Created by Steven Curtis on 10/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

class UserListRetrievalOperation<T: HTTPManagerProtocol>: NetworkOperation {
    var dataFetched: Data?
    var httpManager: T?
    var error: Error?
    var url: URL?
    
    init(url: URL? = nil, httpManager: T) {
        self.url = url
        self.httpManager = httpManager
    }
       
    override func main() {
        guard let url = url else {return}
        httpManager?.get(url: url, completionBlock: { data in
            switch data {
            case .failure(let error):
                self.error = error
                self.complete(result: data)
            case .success(let successdata):
                self.dataFetched = successdata
                self.complete(result: data)
            }
        })
    }
}
