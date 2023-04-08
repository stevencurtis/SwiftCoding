import UIKit

// Not reusable

func printGreeting() {
    print("Hello, world!")
}

printGreeting()

// reusable

func printGreeting(name: String) {
    print("Hello, \(name)!")
}

printGreeting(name: "James") // James
printGreeting(name: "Maria") // Maria
