//: [Previous](@previous)

import Foundation

actor Counter {
    var value = 0
    
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


actor MyActor {
    let myCounter = Counter()
    
    func test() {
        myCounter.value = 8
    }
}
counter.value = 5

//: [Next](@next)
