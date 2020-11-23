import UIKit

let p: Set<String> = ["a", "b", "c", "d", "e", "f"]
let q: Set<String> = ["y", "z"]

class Node<T: Hashable>: Hashable {
    static func == (lhs: Node<T>, rhs: Node<T>) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) { // Generated automatically
      hasher.combine(value)

    }
    
    var value: T
    var parent: Node?
    var children = [Node]()
    init(_ val: T) {
        self.value = val
    }
    
    func addChild(_ node: Node) {
        children.append(node)
        node.parent = self
    }
}

class UnionFind<T: Hashable> {
    // each element has a set number
    var index: [Node<T>: Int] = [:]
    func addSet(_ element: T) {
        // set the element label to the number of the index
        index[Node(element)] = index.count
    }
}

let unionFind = UnionFind<Character>()

unionFind.addSet("A")
print ("E")
