import UIKit
import XCTest

class Node {
    var val: Int
    var left: Node?
    var right: Node?
    init(_ val: Int) {
        self.val = val
    }
    
    func insert(_ val: Int) {
        if val < self.val {
            // lhs
            if let ln = self.left {
                ln.insert(val)
            } else {
                let newNode = Node(val)
                self.left = newNode
            }
        } else {
            // rhs
            if let rn = self.right {
                rn.insert(val)
            } else {
                let newNode = Node(val)
                self.right = newNode
            }
        }
    }
    
    func bfsReturnVals() -> [Int] {
        var queue: [Node] = [self]
        var orderedOutput: [Int] = []
        while let head = queue.first {
            queue.remove(at: 0)
            orderedOutput.append(head.val)
            if let lft = head.left {
                queue.append(lft)
            }
            if let rgt = head.right {
                queue.append(rgt)
            }
        }
        return orderedOutput
    }
}

class bfsTests: XCTestCase {
    var bt = Node(10)
    var largeBt = Node(15)

    override func setUp() {
        bt.insert(5)
        bt.insert(20)
        bt.insert(3)
        bt.insert(15)

    }
    func testbfsReturnVals() {
        measure {
            XCTAssertEqual(bt.bfsReturnVals(), [10,5,20,3,15])
        }
    }
    
}

bfsTests.defaultTestSuite.run()
