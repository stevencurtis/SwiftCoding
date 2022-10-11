import UIKit

let capitals = ["London", "New Delhi", "Naypyitaw", "Kathmandu"]

for capital in capitals {
    // print (capital)
}

var capitalIterator = capitals.makeIterator()
for capital in capitalIterator {
    // print (capital)
}

struct CountDownIterator: IteratorProtocol {
    var current: Int
    mutating func next() -> Int? {
        if current == 0 {
            return nil
        } else {
            defer { current -= 1 }
            return current
        }
    }
}


struct CountDown: Sequence {
    var count: Int
    
    func makeIterator() -> some IteratorProtocol {
        return CountDownIterator(current: count)
    }
    
//    mutating func next() -> Int? {
//        if count == 0 {
//            return nil
//        } else {
//            defer { count -= 1 }
//            return count
//        }
//    }
}

let threeToGo = CountDown(count: 3)
for i in threeToGo {
    print (i)
}
