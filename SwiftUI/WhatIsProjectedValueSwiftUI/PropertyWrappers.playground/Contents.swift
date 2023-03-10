import UIKit
import SwiftUI
import Combine


@propertyWrapper
struct MyStringWrapper {
    var wrappedValue: String
    
    var projectedValue: String {
        get {wrappedValue}
        set {wrappedValue = newValue}
    }
}

class AnObject {
    @MyStringWrapper var myString = "Hello, World!"
}

let object = AnObject()
print (object.myString)
//print (object._myString)
print (object.$myString)


@propertyWrapper
struct MyPublished {
    internal var wrappedValue: String
    private let innerSubject = PassthroughSubject<String, Never>()
    
    init(wrappedValue value: String) {
        self.wrappedValue = value
        self.value = value
    }
    
    var value: String {
        get {
            return self.wrappedValue
        }
        set {
            self.wrappedValue = newValue
            self.innerSubject.send(wrappedValue)
        }
    }
    
    private var asPublisher: AnyPublisher<String, Never> {
        return self.innerSubject.eraseToAnyPublisher()
    }
}

extension MyPublished: Publisher {
    typealias Output = String
    typealias Failure = Never

    func subscribe<S>(_ subject: S) -> AnyCancellable where S : Subject, Self.Failure == S.Failure, Self.Output == S.Output {
        return self.asPublisher.subscribe(subject)
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
        return self.asPublisher.receive(subscriber: subscriber)
    }
}


class MyDevice: ObservableObject {
    @MyPublished var major: String = "1"
//    var major = 1
    var minor: Int = 0
    var patch: Int = 0
    
    func updateToNewVersion() {
        _major.value = "2"
//        major.$value = 2
        minor = 0
        patch = 0
    }
}

let tablet = MyDevice()
print ("version: \(tablet.major).\(tablet.minor).\(tablet.patch)")

let cancellable = tablet.objectWillChange
    .sink { _ in
        print ("\(tablet.major).\(tablet.minor).\(tablet.patch) willChange")
}

tablet.updateToNewVersion()
