//: [Previous](@previous)

import Foundation

// Generic

func printGreeting<T: CustomStringConvertible>(name: T) {
    print("Hello, \(name)!")
}

printGreeting(name: "John") // "Hello, John!"

// The following now causes a compiler error
//printGreeting(name: {}) // "Hello, (Function)!"
//: [Next](@next)
