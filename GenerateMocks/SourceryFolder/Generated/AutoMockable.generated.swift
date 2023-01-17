// Generated using Sourcery 1.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif














class GreetingProtocolMock: GreetingProtocol {

    //MARK: - sayHello

    var sayHelloCallsCount = 0
    var sayHelloCalled: Bool {
        return sayHelloCallsCount > 0
    }
    var sayHelloReturnValue: String!
    var sayHelloClosure: (() -> String)?

    func sayHello() -> String {
        sayHelloCallsCount += 1
        return sayHelloClosure.map({ $0() }) ?? sayHelloReturnValue
    }

}
class TestProtocolMock: TestProtocol {

}
