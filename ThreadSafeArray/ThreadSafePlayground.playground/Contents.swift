import UIKit

var str = "Hello, playground"

//var array : [Int] = [0]

//DispatchQueue.concurrentPerform(iterations: 6) { index in
//    array.append( array.last! + 1 )
//}
//print (array.count)


public class SafeArray {
    private var array: [Int] = []
    private let accessQueue = DispatchQueue(label: "SynchronizedArrayAccess", attributes: .concurrent)
    
    init(repeating: Int, count: Int) {
        array = Array(repeating: repeating, count: count)
    }
    
//    public var description: String {
//        return array.description
//    }
    
    public func append(_ newElement: Int) {
        // write uses async
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

//var array = SynchronizedArray(repeating: 2, count: 3)
//array.append(newElement: 1)
//print (array)

var array = SafeArray(repeating: 0, count: 1)

DispatchQueue.concurrentPerform(iterations: 6) { index in
    // print (index)
    array.append(array.last! + 1 )
}
print (array.count)


