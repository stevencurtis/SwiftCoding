//
//  OperationMock.swift
//  OperationQueueDependentAPICallsTests
//
//  Created by Steven Curtis on 11/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
@testable import OperationQueueDependentAPICalls


class OperationMock: Operation {
    typealias CompletionHandler = () -> Void
    var completionHandler: (CompletionHandler)?
    var delay = 0.0
    override func main() {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
            self.completionHandler?()
        })
    }
}
