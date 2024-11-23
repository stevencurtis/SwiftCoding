# Swift Queues
## One thing after another


I've previously written an article about [stacks](https://betterprogramming.pub/generics-in-swift-aa111f1c549) and I think that is a good starting place for today's article on the queue data structure as implemented in Swift.

But I can do better. So onto this article, where I'm going to explore a basic queue implementation, identify performance bottlenecks and write a *better* implementation.

Whether you're new to Swift or looking to refine your data structure skills, this article will help you gain a deeper understanding of queues and their significance in building performant iOS applications.

Here is a simple representation of the stack:

```swift
class Stack<T> {
    var elements = [T]()
    func pop () -> T? {
        if let last = elements.last {
            elements = elements.dropLast()
            return last
        }
        return nil
    }
    
    func push(_ element: T) {
        elements.append(element)
    }
}
```

If I were to rewrite this data structure today I might update it to make the class final and to use `removeLast` to simplify the logic but generally I'm comfortable with this LIFO (Last in, First Out Data structure) as long as I (finally) make that array private. I still prefer reference semantics for this type of data structure so I came up with:

```swift
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
```

This gives the output as below:

```swift
Optional(4)
Optional(3)
Optional(2)
nil
```

I can then think about how I might code a queue.

## A Queue
A queue is a FIFO (First in First Out) data structure.

```swift
final class Queue<T> {
    private var elements: [T] = []
    func enqueue(element: T) {
        elements.append(element)
    }
    
    func dequeue() -> T? {
        guard !elements.isEmpty else { return nil }
        return elements.removeFirst()
    }
}
```

The dequeue method provides us with an opportunity here. `removeFirst()` is an O(n) operation as the remaining elements have to shifted down by one position.

We can find a more performant solution. Let's take a look.

## Optimising queue performance

```swift
final class Queue<T> {
    private var inbox: [T] = []
    private var outbox: [T] = []

    func enqueue(element: T) {
        inbox.append(element)
    }
    
    func dequeue() -> T? {
        if outbox.isEmpty {
            outbox = inbox.reversed()
            inbox.removeAll()
        }
        return outbox.popLast()
    }
}
```

Elements are enqueued into the inbox stack.
When an element needs to be dequeued, if outbox is empty, we reverse inbox and transfer all elements to outbox. This operation is O(n), but it only happens once for each batch of enqueued elements, spreading the cost over several dequeue operations.
`popLast()` on outbox is then an O(1) operation, significantly increasing efficiency, especially in scenarios with frequent enqueue and dequeue actions.

``` swift
final class Queue<T> {
  private var items: [T?]
  private var head = 0
  private var tail = 0
  private var count = 0

  init(initialCapacity: Int = 10) {
    items = Array(repeating: nil, count: initialCapacity)
  }

  func enqueue(_ element: T) {
    if count == items.count { // Resize if full
      resize(capacity: items.count * 2)
    }
    items[tail] = element
    tail = (tail + 1) % items.count
    count += 1
  }

  func dequeue() -> T? {
    guard count > 0 else { return nil } // Empty queue

    let element = items[head]
    items[head] = nil  // Clear the slot to prevent memory leak with reference types
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

```

# Conclusion

Mastering data structures like queues is vital for building responsive, efficient applications, especially in a language like Swift, where the balance of simplicity and performance is key. I hope this article has not only clarified how queues work but also inspired you to think critically about performance trade-offs in your own projects. By choosing the right implementation, you can ensure your applications handle data in the most effective way possible, providing a smooth experience for your users.
