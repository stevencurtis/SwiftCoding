//  Created by Steven Curtis

import Foundation
@testable import DependencyInversion

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    func cancel() { }
    
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    func resume() {
        closure()
    }
}
