//
//  UserDecodeOperation.swift
//  OperationQueueDependentAPICalls
//
//  Created by Steven Curtis on 11/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

class UserDecodeOperation: Operation {
    var dataFetched: Data?
    var error: Error?
    var decodedURL: URL?
    typealias CompletionHandler = (_ result: UserModel?) -> Void
    var completionHandler: (CompletionHandler)?

    override func main() {
        guard let dataFetched = dataFetched, error == nil else { cancel(); return }
        let decoder = JSONDecoder()
        do {
            let content = try decoder.decode(UserModel.self, from: dataFetched)
            completionHandler?(content)
        } catch {
            self.error = error
            completionHandler?(nil)
        }
    }
}
