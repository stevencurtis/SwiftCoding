import UIKit

func printStringLength(_ str: String?) {
    let length = str?.count ?? 0
    print("String length: \(length)")
}

printStringLength("Hello") // Prints "String length: 5"

let str: String? = nil
printStringLength(str) // In Swift 5.9, error occurs here as we are trying to pass a nil value to a function that expects a non-nil string

struct Pair<First, Second> {
    let first: First
    let second: Second
    init(_ first: First, _ second: Second) {
        self.first = first
        self.second = second
    }
}

func makePairs<each First, each Second>(
  firsts first: repeat each First,
  seconds second: repeat each Second
) -> (repeat Pair<each First, each Second>) {
    (repeat Pair(each first, each second))
}

let pairs = makePairs(firsts: 1, "hello", seconds: true, 1.0)
print(pairs)



//struct Person: ~Copyable {
//    var name: String
//}
//
//let person = Person(name: "T Swift")
//let secondPerson = person



actor Counter {
    private var value = 0
    private let queue: DispatchSerialQueue
    
    init(value: Int = 0, queue: DispatchSerialQueue) {
        self.value = value
        self.queue = queue
    }
    
    nonisolated var unownedExecutor: UnownedSerialExecutor { queue.asUnownedSerialExecutor() }

    func next() -> Int {
        let current = value
        value = value + 1
        return current
    }
    
    func total() -> Int {
        value
    }
}

let counter = Counter(queue: DispatchSerialQueue.main as! DispatchSerialQueue)

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
