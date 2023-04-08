//: [Previous](@previous)

import Foundation

// Generic

func printGreeting<T>(name: T) {
    print("Hello, \(name)!")
}

printGreeting(name: "John") // "Hello, John!"
printGreeting(name: 42) // "Hello, 42!"
printGreeting(name: ["John", "Jane"]) // "Hello, ["John", "Jane"]!"
printGreeting(name: {}) // "Hello, (Function)!"

//: [Next](@next)
