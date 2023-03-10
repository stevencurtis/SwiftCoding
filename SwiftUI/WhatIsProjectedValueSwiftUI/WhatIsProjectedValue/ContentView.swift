//
//  ContentView.swift
//  WhatIsProjectedValue
//
//  Created by Steven Curtis on 20/11/2020.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var myText = MyText()
    var body: some View {
        Text(myText.textValue)
            .padding()
        TextField("", text: $myText.textValue)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .autocapitalization(.none)
        Text(myText.secondValue)
            .padding()
        TextField("", text: $myText.secondValue)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .autocapitalization(.none)
    }
}

class MyText: ObservableObject {
    @Published var textValue: String = "Hello, World!"
    @MyPublished var secondValue: String = "Hello, World!"
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//https://gist.github.com/twittemb/a7de9431d70d535a6c003b4ec753e10c
@propertyWrapper
struct MyPublished: Publisher {
    typealias Output = String
    
    typealias Failure = Never

    private let subject: CurrentValueSubject<String, Never>

    var wrappedValue: String {
        get { subject.value }
        set { subject.value = newValue }
    }
    
    init(wrappedValue initialValue: String) {
        subject = CurrentValueSubject<String, Never>(initialValue)
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, MyPublished.Failure == S.Failure, MyPublished.Output == S.Input {
        subject.receive(subscriber: subscriber)
    }
}

//@propertyWrapper
//struct MyPublished {
//    internal var wrappedValue: String
//
//    // Publish values on demand using send(_:)
//    private let innerSubject = PassthroughSubject<String, Never>()
//
//    init(wrappedValue value: String) {
//        self.wrappedValue = value
//        self.projectedValue = value
//    }
//
//    var projectedValue: String {
//        get {
//            self.wrappedValue
//        }
//
//        set {
//            self.innerSubject.send(wrappedValue) // effectively will set
//            self.wrappedValue = newValue
//        }
//    }
//
//    private var asPublisher: AnyPublisher<String, Never> {
//        return self.innerSubject.eraseToAnyPublisher()
//    }
//}

//extension MyPublished: Publisher {
//    typealias Output = String
//    typealias Failure = Never
//
//    func subscribe<S>(_ subject: S) -> AnyCancellable where S : Subject, Self.Failure == S.Failure, Self.Output == S.Output {
//        return self.asPublisher.subscribe(subject)
//    }
//
//    //Acknowledges the subscribe request and returns a Subscription instance. The subscriber uses the subscription to demand elements from the publisher and can use it to cancel publishing.
//    func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
//        return self.asPublisher.receive(subscriber: subscriber)
//    }
//}

