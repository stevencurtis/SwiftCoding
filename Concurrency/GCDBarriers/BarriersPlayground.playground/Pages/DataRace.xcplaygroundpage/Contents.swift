//: [Previous](@previous)

import Foundation

//--  Data race example
final class Counter {
    var count = 0

    func inc() {
        count += 1
    }
}

let counter = Counter()

DispatchQueue.global().async {
    for _ in 0..<1000 {
        counter.inc()
    }
}

DispatchQueue.global().async {
    for _ in 0..<1000 {
        counter.inc()
    }
}

Thread.sleep(forTimeInterval: 1)
print(counter.count) // sometimes 1999, 2000 ...

//: [Next](@next)
