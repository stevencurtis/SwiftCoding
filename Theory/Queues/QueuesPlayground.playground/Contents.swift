import UIKit

final class Stack<T> {
    private var elements: [T] = []
    
    func pop() -> T? {
        guard !elements.isEmpty else { return nil }
        return elements.removeLast()
    }
    
    func push(element: T) {
        elements.append(element)
    }
    
    func peek() -> T? {
        elements.last
    }
    
    func isEmpty() -> Bool {
        elements.isEmpty
    }
}

var stack = Stack<Int>()
stack.push(element: 2)
stack.push(element: 3)
stack.push(element: 4)

//print(stack.pop())
//print(stack.pop())
//print(stack.pop())
//print(stack.pop())

//final class Queue<T> {
//    private var elements: [T] = []
//    func enqueue(element: T) {
//        elements.append(element)
//    }
//    
//    func dequeue() -> T? {
//        guard !elements.isEmpty else { return nil }
//        return elements.removeFirst()
//    }
//}

//final class Queue<T> {
//    private var inbox: [T] = []
//    private var outbox: [T] = []
//
//    func enqueue(element: T) {
//        inbox.append(element)
//    }
//    
//    func dequeue() -> T? {
//        if outbox.isEmpty {
//            outbox = inbox.reversed()
//            inbox.removeAll()
//        }
//        return outbox.popLast()
//    }
//}

final class Queue<T> {
  private var items: [T?]
  private var head = 0
  private var tail = 0
  private var count = 0

  init(initialCapacity: Int = 10) {
    items = Array(repeating: nil, count: initialCapacity)
  }

  func enqueue(element: T) {
    if count == items.count { // Resize if full
      resize(capacity: items.count * 2)
    }
    items[tail] = element
    tail = (tail + 1) % items.count
    count += 1
  }

  func dequeue() -> T? {
    guard count > 0 else { return nil }

    let element = items[head]
    items[head] = nil
    head = (head + 1) % items.count
    count -= 1

    return element
  }

  private func resize(capacity: Int) {
    var newArray = Array<T?>(repeating: nil, count: capacity)
    for i in 0..<count {
      newArray[i] = items[(head + i) % items.count]
    }
    head = 0
    tail = count
    items = newArray
  }
}


var queue = Queue<Int>()
queue.enqueue(element: 1)
queue.enqueue(element: 2)
print(queue.dequeue())
print(queue.dequeue())
print(queue.dequeue())
