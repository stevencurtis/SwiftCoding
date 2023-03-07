//: [Previous](@previous)

import Foundation

final class Counter {
    private var _count = 0
    private let lock = NSLock()

    func inc() {
        lock.lock()
        defer {
            lock.unlock()
        }
        _count += 1
    }

    var count: Int {
        lock.lock()
        defer {
            lock.unlock()
        }
        return _count
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
print(counter.count)

//: [Next](@next)
