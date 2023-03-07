//: [Previous](@previous)

import Foundation

final class Counter {
    private var count = 0
    private let queue = DispatchQueue(label: "myQueue", attributes: .concurrent)

    func inc() {
        queue.sync(flags: .barrier) {
            self.count += 1
        }
    }

    var value: Int {
        return queue.sync {
            self.count
        }
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
print(counter.value) // always 2000

//: [Next](@next)
