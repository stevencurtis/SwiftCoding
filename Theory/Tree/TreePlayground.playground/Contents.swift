import UIKit

final class BinaryNode {
    var left: BinaryNode?
    var right: BinaryNode?
    var value: Int
    
    init(value: Int) {
        self.value = value
    }
}

let node = BinaryNode(value: 9)
let fiveNode = BinaryNode(value: 5)
let twelveNode = BinaryNode(value: 12)
node.left = fiveNode
node.right = twelveNode

//struct BinaryNode {
//    var value: Int
//    var leftChild: BinaryNode?
//    var rightChild: BinaryNode?
//}

struct Node {
    var children = [Node]()
    let value: Int
    init(value: Int) {
        self.value = value
    }
    mutating func addChild(node: Node) {
        children.append(node)
    }
}

var treeNode = Node(value: 9)
treeNode.addChild(node: Node(value: 5))
treeNode.addChild(node: Node(value: 12))

indirect enum BinaryTreeNode<T> {
    case node(
        value: T,
        leftChild: BinaryTreeNode?,
        rightChild: BinaryTreeNode?
    )
    case empty

    mutating func addLeftChild(_ child: BinaryTreeNode) {
        switch self {
        case .node(let value, _, let rightChild):
            self = .node(value: value, leftChild: child, rightChild: rightChild)
        case .empty:
            break
        }
    }
    
    mutating func addRightChild(_ child: BinaryTreeNode) {
        switch self {
        case .node(let value, let leftChild, _):
            self = .node(value: value, leftChild: leftChild, rightChild: child)
        case .empty:
            break
        }
    }
}

var root = BinaryTreeNode.node(value: 1, leftChild: nil, rightChild: nil)
let leftChild = BinaryTreeNode.node(value: 2, leftChild: nil, rightChild: nil)
let rightChild = BinaryTreeNode.node(value: 3, leftChild: nil, rightChild: nil)

root.addLeftChild(leftChild)
root.addRightChild(rightChild)

final class GenericTreeNode<T> {
    let value: T
    var left: GenericTreeNode?
    var right: GenericTreeNode?
    init(value: T) {
        self.value = value
    }
}

extension GenericTreeNode: CustomStringConvertible {
    var description: String {
        var nodeDescription = "\(value)"
        if let left {
            nodeDescription += "<-\(left.description)"
        }
        if let right {
            nodeDescription += "->\(right.description)"
        }
        return nodeDescription
    }
}

let rootNode = GenericTreeNode(value: 9)
rootNode.left = GenericTreeNode(value: 5)
rootNode.right = GenericTreeNode(value: 12)

print(rootNode) // 9<-5->12
