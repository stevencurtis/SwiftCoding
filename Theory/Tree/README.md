# A Binary Tree in Swift
## A Simple Data Structure!

## Prerequisites:
You will be expected to be able to create Swift programs in Playgrounds, or some other method of your choice

# Terminology:
Binary: The name of the base 2 number system
Binary Tree: A data structure in which a node is linked to two child nodes, referred to as the left and right children
Complete binary tree: A binary tree in which every level, except possibly the last is completely filled from the left
Full binary tree: A binary tree in which every node other than the leaves contain two children
Leaf nodes: Nodes that have empty subtrees

# The Theory
## Nodes
Each **Node** contains three elements:
- The data
- A pointer to the left child
- A pointer to the right child

Pointers can either point to a Node, or can be nil

[Images/node.png](Images/node.png)</br>
A node (storing 9 as it's data) with two nil children
[Images/nodenine.png](Images/nodenine.png)</br>
A node (storing 9 as data) with two pointers - a Left and a Right pointer

## Trees
A tree is a collection of nodes (each node itself contains zero or more nodes as children), and a single node is a tree.

[Images/tree.png](Images/tree.png)</br>

# The Implementation using Reference Semantics
## Class Nodes

I've chosen to make my node a class as it is a reference type - when copied a reference type keeps a single copy of the data (in this case a node).

[Images/playgroundprint.png](Images/playgroundprint.png)</br>

```swift
final class BinaryNode {
    var left: BinaryNode?
    var right: BinaryNode?
    var value: Int
    
    init(value: Int) {
        self.value = value
    }
}
```

Which can then be populated with the values as above (the parent node has 9 the left node with 5 and the right node with 12).

```swift
let node = BinaryNode(value: 9)
let fiveNode = BinaryNode(value: 5)
let twelveNode = BinaryNode(value: 12)
node.left = fiveNode
node.right = twelveNode
```

# The Implementation using Value Semantics
You might want a tree that uses value semantics for thread-safety, copy-on-write optimisation or the simplicity of design.

## Simple Struct Trees (will not work)
But what if we attempt to build a simple node as a struct? 

We would be restricted to value semantics meaning adding a node to a tree would result in a new copy of the node. This behaviour is not suitable for trees as it breaks the shared reference model.

That's not the only problem. `struct` are value types, and do not support recursive structures, because that would lead to an infinitely sized type.

A naive example would be:

```swift
struct TreeNode {
    var value: Int
    var leftChild: TreeNode?
    var rightChild: TreeNode? // Value type 'TreeNode' cannot have a stored property that recursively contains it
}
```

If the struct `TreeNode` directly contains another instance of `TreeNode` the compiler would try to allocate memory for it. This would recursively require memory for another `TreeNode`. Even though these are optional properties the compiler needs to account for the maximum possible size that an instant of the struct might occupy, and the recursive nature of the tree leads to an unbound structure. 

Since the compiler disallows directly recursive structs, the error `// Value type 'TreeNode' cannot have a stored property that recursively contains it` is used. This gives the Swift compiler the advantage of simpler and more predicable behaviour.

Don't worry. There are solutions to this.

## A Tree Using Value Semantics
Since we cannot use recursive structs we need a new approach. For this we can use an *array* to store the children.

This means we can store more than two children, so while it is possible to store a binary tree (that has just two children) this is more a tree than a binary tree. If we want to use this structure we are left to enforce there being two children and have the discipline to have a right and left node.

```swift
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
```

This can be populated with the following:

```swift
var treeNode = Node(value: 9)
treeNode.addChild(node: Node(value: 5))
treeNode.addChild(node: Node(value: 12))
```

## Indirect Enum
If we want to implement a tree with value semantics we can use enum (that are value types) using the `indirect` keyword. This allows enums to have cases that are recursively defined.

Here is how you can implement a binary tree using such an enum, and get the advantages of using value types.

```swift
indirect enum BinaryTreeNode<T> {
    case node(value: T, leftChild: BinaryTreeNode?, rightChild: BinaryTreeNode?)
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
```

# Generics and CustomStringConvertible
These trees ignore generics. They also do not print the tree (and CustomStringConvertible can help here).

Here is a possible implementation:

```swift
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
```

# Conclusion
I intended this article to be a simple one covering binary trees. It seems like it's expanded somewhat, but I hope that it is still useful if you are reading this.

Anyway, best of luck!

I'd love to hear from you if you have questions for me!
You might like to help me out by buying me a coffee on https://www.buymeacoffee.com/stevenpcuri.
