//
//  UserListDecodeOperation.swift
//  OperationQueueDependentAPICalls
//
//  Created by Steven Curtis on 11/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

class UserListDecodeOperation: Operation {
    var dataFetched: Data?
    var error: Error?
    var decodedURL: URL?
    typealias CompletionHandler = (_ result: ListUsersModel?) -> Void
    var completionHandler: (CompletionHandler)?

    override func main() {
        guard let dataFetched = dataFetched else { return }
        let decoder = JSONDecoder()
        do {
            let content = try decoder.decode(ListUsersModel.self, from: dataFetched)
            if let id = content.data.first?.id {
                  self.decodedURL = URL(string: Constants.baseURL + "/" + String(id) )
                completionHandler?(content)
            } else {
                self.error = OQError.runtimeError("Unexpected Data")
                completionHandler?(nil)
            }
        } catch {
            self.error = error
            completionHandler?(nil)
        }
    }
}
