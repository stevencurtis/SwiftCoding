import UIKit
import XCTest


class Node: CustomStringConvertible {
    var description: String { return "\(self.data)" }
    var data: Int
    var left: Node?
    var right: Node?
    
    init(_ data: Int) {
        self.data = data
    }
    
    func insert(_ data: Int) {
        if (data < self.data){
            if let lft = self.left {
                lft.insert(data)
            } else {
                let newNode = Node(data)
                left = newNode
            }
        } else {
            if let rht = self.right {
                rht.insert(data)
            } else {
                let newNode = Node(data)
                right = newNode
            }
        }
    }
}


func dfsRecursiveVals(_ node: Node) -> [Int]{
    var visitedNodes = [Int]()
    if let lft = node.left {
        visitedNodes += dfsRecursiveVals(lft)
    }
    visitedNodes.append(node.data)
    if let rgt = node.right {
        visitedNodes += dfsRecursiveVals(rgt)
    }
    return visitedNodes
}

class dfsTests: XCTestCase {
    var bt = Node(10)
    var largeBt = Node(15)
    let regularTree = Node(20)

    override func setUp() {
        bt.insert(5)
        bt.insert(20)
        bt.insert(3)
        bt.insert(15)

        
        largeBt.insert(9)
        largeBt.insert(5)
        largeBt.insert(12)
        largeBt.insert(11)
        largeBt.insert(2)
        largeBt.insert(7)
        largeBt.insert(22)
        largeBt.insert(18)
        largeBt.insert(25)
        largeBt.insert(17)
        largeBt.insert(19)
        largeBt.insert(24)
        largeBt.insert(31)
        
        regularTree.insert(8)
        regularTree.insert(4)
        regularTree.insert(12)
        regularTree.insert(10)
        regularTree.insert(14)
        regularTree.insert(22)
    }
    
    func testdfsReturnVals() {
        measure {
            XCTAssertEqual(dfsRecursiveVals(bt), [3,5,10,15,20])
            XCTAssertEqual(dfsRecursiveVals(regularTree), [4, 8, 10, 12, 14, 20, 22])

        }
    }
    
    func testLargeInorderReturnVals() {
        measure {
            XCTAssertEqual(dfsRecursiveVals(largeBt), [2,5,7,9,11,12,15,17,18,19,22,24,25,31])
        }
    }


}

dfsTests.defaultTestSuite.run()
