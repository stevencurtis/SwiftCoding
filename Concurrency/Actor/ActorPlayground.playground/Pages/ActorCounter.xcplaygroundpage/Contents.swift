//: [Previous](@previous)

import Foundation

actor Counter {
    private var value = 0
    
    func next() -> Int {
        let current = value
        value = value + 1
        return current
    }
    
    func total() -> Int {
        value
    }
}

let counter = Counter()

Task {
    for _ in 0..<1000 {
        await (counter.next())
    }
}

Task {
    for _ in 0..<1000 {
        await (counter.next())
    }
}

try await Task.sleep(nanoseconds: 1000000000)
await print(counter.total())
//: [Next](@next)
