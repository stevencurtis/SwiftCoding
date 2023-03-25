import UIKit

class Counter {
    var count = 0

    func inc() {
        count += 1
    }
}

let counter = Counter()

//DispatchQueue.global().async {
//    for _ in 0..<1000 {
//        counter.inc()
//    }
//}
//
//DispatchQueue.global().async {
//    for _ in 0..<1000 {
//        counter.inc()
//    }
//}
//
//Thread.sleep(forTimeInterval: 1)
//print(counter.count)

var tasks = [Task<Void, Never>]()
tasks += [
    Task.detached {
        counter.inc()
    }
]

tasks += [
    Task.detached {
        counter.inc()
    }
]

print(counter.count)
