# Swift thread-safe arrays
## Be careful! They are value types!

Difficulty: Beginner | Easy | **Normal** | Challenging<br/>
This article has been developed using Xcode 11.7, and Swift 5.2.4

## Prerequisites: 
* You will be expected to make a [Single View SwiftUI Application](https://medium.com/@stevenpcurtis.sc/hello-world-swiftui-92bcf48a62d3) in Swift.

## Terminology
Array: An ordered series of objects which are the same type

# The motivation
[Concurrency](https://medium.com/swift-coding/concurrency-and-grand-central-dispatch-in-swift-gcd-f0ae063973c2) is a big part of programming and coding.

Since many devices (including iOS devices) embrace the principles of parallelism (that is, executing on many threads at the same time).  

![Parallelism](Images/parallelism.png)<br/>

There is a special type of problem in Computer Science - The **Readers-Writers problem**.

Because there are multiple threads, one thread may be reading a shared resource (in this case an Array) while another thread writes the same resource.

Here lies disaster!

Since Arrays are [Value types](https://medium.com/swlh/value-and-reference-types-in-swift-3abf240edba) but this doesn't help in preventing the **Readers-Writers problem**.

This sucks.

# The practical example
Warning: The following code is not thread-safe (by definition - that is the point). This means that the code can and will crash at times because the code is simultaneously reading and writing at the same location - this is the point.

We set up an array (I've called it `Array` due to creativity issues). 

```swift
var array : [Int] = [0]

DispatchQueue.concurrentPerform(iterations: 6) { index in
    array.append( array.last! + 1 )
}
print (array.count)
```

Expected output:

```swift
6
```

Actual output:
A crash, or all sorts of variations where we have corrupted data and:
-  the output does, or does not have 6 elements

This is trash! 
We must fix this!

Note: The contents of the actual array can still be messed up bad, but this is not particuarly relevant to this example.

# The solution
We place Swift's [Dispatch Barrier](https://developer.apple.com/documentation/dispatch/dispatch_barrier) to allow concurrent reads while blocking write.

This particular solution is **not** generic, as this is not a prerequisite of this article!

```swift
public class SafeArray {
    private var array: [Int] = []
    private let accessQueue = DispatchQueue(label: "SynchronizedArrayAccess", attributes: .concurrent)
    
    init(repeating: Int, count: Int) {
        array = Array(repeating: repeating, count: count)
    }

    public func append(_ newElement: Int) {
        self.accessQueue.async(flags:.barrier) {
            self.array.append(newElement)
        }
    }

    public var count: Int {
        var count = 0
        self.accessQueue.sync {
            count = self.array.count
        }
        return count
    }

    var last: Int? {
        var element: Int?
        self.accessQueue.sync {
            if !self.array.isEmpty {
                element = self.array[self.array.count - 1]
            }
        }
        return element
    }
}
```

Note: The contents of the actual array can still be messed up bad, but this is not particuarly relevant to this example.

# Conclusion
You need to be careful even with value types when in a multi-threaded environment. This article has given a rather brief introduction and I hope you've enjoyed it.

 If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 