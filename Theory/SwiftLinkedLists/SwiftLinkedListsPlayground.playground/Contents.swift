import UIKit

var greeting = "Hello, playground"

class Node {
    var val: Int
    var next: Int?
    init(val: Int) {
        self.val = val
    }
}

let head: Node = Node(val: 3)
print(head)
