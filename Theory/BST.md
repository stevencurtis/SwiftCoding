# Binary Search Tree

```swift
class Node<T> {
  var value: T
  var leftChild: Node?
  var rightChild: Node?

  init(value: T) {
    self.value = value
  }
}
```

# Definitions
Full binary tree - Every node has two children (other than the leaves)
Complete - Every level, except possibly the last, is completely filled and all nodes are as far left as possible
Perfect - Every node has two children, and all leaves are at the same depth
Balanced - Left and right subtrees differ in height by no more than 1
Degenerate - Each parent node only has one associated child, so the tree behaves like a linked list

AVL tree - AVL tree is a self-balancing Binary Search Tree (BST) where the difference between heights of left and right subtrees cannot be more than one for all nodes. [https://www.geeksforgeeks.org/avl-tree-set-1-insertion/](https://www.geeksforgeeks.org/avl-tree-set-1-insertion/)

## Indicies of nodes
leftChild = 2n + 1
rightChild = 2n + 2
parent = (n - 1) / 2

## Complete binary tree
Leaf nodes: (n + 1) /2
Nodes - 2n - 1 nodes where n leaves
Height log2n
## Perfect binary tree
height with n nodes - log2(n + 1 ) - 1


## searching complexity
**Binary tree - so the smallest value "could" be on the right**
Searching: For searching element 2, we have to traverse all elements (assuming we do breadth first traversal). Therefore, searching in binary tree has worst case complexity of O(n).
Insertion: For inserting element as left child of 2, we have to traverse all elements. Therefore, insertion in binary tree has worst case complexity of O(n).
Deletion: For deletion of element 2, we have to traverse all elements to find 2 (assuming we do breadth first traversal). Therefore, deletion in binary tree has worst case complexity of O(n).

**Binary searach tree - so the smallest value is on the left, and the largest is on the right**
Searching: For searching element 1, we have to traverse elements (in order 5, 4, 1) = 3 = log2n. Therefore, searching in AVL tree has worst case complexity of O(log2n).
Insertion: For inserting element 12, it must be inserted as right child of 9. Therefore, we need to traverse elements (in order 5, 7, 9) to insert 12 which has worst case complexity of O(log2n).
Deletion: For deletion of element 9, we have to traverse elements to find 9 (in order 5, 7, 9). Therefore, deletion in binary tree has worst case complexity of O(log2n).


## Adjacency list
```swift
class Node: Hashable {
    var nodes = [String:[String]]()
    var hashValue: Int{ return nodes.hashValue }
    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.nodes.keys == rhs.nodes.keys
    }
}

//Graph class used because you may not be able to reach all the nodes from a single node
class Graph: CustomStringConvertible {
    var description: String { return "" }
    var children = [Node]()
    
    func showNodes() {
        for child in children {
            print ( "from", child.nodes.keys , "to", child.nodes.values)
        }
    }
    
    func addEdge(from: String, to: String) {
        if (children.contains{ $0.nodes[from] != nil}) {
            for child in children {
                if (child.nodes[from] != nil) {
                    if (!(child.nodes[from]?.contains{$0 == to})!){
                        child.nodes[from]?.append(to)
                    }
                }
            }
        }
        else {
            let newNode = Node()
            newNode.nodes[from] = [to]
            children.append(newNode)
        }
    }
}

func dfs(graph: Graph, source: Node,  explored: inout [String]) {
    for edges in source.nodes.values {
        for edge in edges {
            if !explored.contains(edge) {
                explored.append(edge)
                for child in graph.children {
                    child.nodes.forEach( {(node) in
                        if (node.key == edge) {
                            dfs(graph: graph, source: child, explored: &explored )
                        }
                    })
                }
            }
        }
    }
}

var myAdjList = Graph()
```

## Minimal tree
```swift
// Given a sorted (increasing order) array with unique integer elements, write an algorithm to create a binary search tree with minimal height

class Node {
    var data: Int? = nil
    var children = [Node]()
    var description: String { return String(data!) + "" + ( (left != nil) ? String(left!.data!) + left!.description + "A" : "d" ) + (right != nil ? String(right!.data!) + right!.description : "n") }
    var left: Node?
    var right: Node?
    func addNode(_ input: Int){
        if (data == nil) {data = input; return}
        let newNode = Node()
        newNode.addNode(input)
        if (input < data!) {
            left = newNode
        }
        else {
            right = newNode
        }
        
    }
    
    func addNodeMinimal(_ input: [Int]) -> Node? {
        if (input == []) {return nil}
        var inp = input
        let midItem = inp.count / 2
        inp[midItem]
        data = inp[midItem]
        
        let left = Node()
        left.addNodeMinimal(Array(inp[0..<midItem]))
        
        
        let right = Node()
        right.addNodeMinimal(Array( inp[midItem+1..<inp.count]) )
        
        return self
    }
}
```

## List of depths
// Given a binary tree, design an algorithm which creates a linked list of all the nodes at each depth (e.g. if you have a tree with depth D, you'll have D linked lists)
```swift
class llNode: CustomStringConvertible {
    var description: String {return String(data) + (next != nil ? next!.description : "")}
    var next: llNode?
    var data: Int

    init(data: Int) {
        self.data = data
    }
    
    func appendToTail(data: Int) {
        if (next != nil) {
            next?.appendToTail(data: data)
        } else {
            next = llNode(data: data)
        }
    }
}

class Node: CustomStringConvertible {
    var data: Int
    var description: String {return String(data) + ( (left != nil) ? left!.description : "" )  + ( (right != nil) ? right!.description : "" ) }
    var left: Node?
    var right: Node?

    init(data: Int) {
        self.data = data
    }
    
    func insert(_ data: Int){
        if (self.data > data) {
            // lhs
            if let lh = self.left {
                lh.insert(data)
            }
            else {
                let lhs = Node(data: data)
                self.left = lhs
            }
        }
        else {
            if let rh = self.right {
                rh.insert(data)
            } else {
                let rhs = Node(data: data)
                self.right = rhs
            }
        }
    }
    
    var linkedListArray = [llNode]()
    
    func bfsLevels(_ level: Int? = nil) {
        let lev = level ?? 1
        if let lft = left {

            if ( linkedListArray.count < lev ) {

                let newllNode = llNode(data: left!.data)
                linkedListArray.append(newllNode)

            }
            else {
                print ("B")

            linkedListArray[lev-1].appendToTail(data: left!.data)
            }
            lft.levels(lev + 1)
        }

        
        if let rgt = right {

            if ( linkedListArray.count < lev ) {

                let newllNode = llNode(data: right!.data)
                linkedListArray.append(newllNode)
            }
            else {
                print ("A", linkedListArray.count, lev)

            linkedListArray[lev-1].appendToTail(data: right!.data)
            }
            rgt.levels(lev + 1)
        }
        
    }

    func levels(_ level: Int? = nil) -> Int {
        let lev = level ?? 0
        if ((right == nil) && (left == nil)) {return lev}
        if (right == nil) { print ("l"); return (left?.levels(lev+1))!}
        if (left == nil) { return (right?.levels(lev+1))!}
        return max((left?.levels(lev+1))!, (right?.levels(lev+1))!)
    }
}
```

## Sucessor
```swift
class Node : CustomStringConvertible, Hashable{
    var hashValue : Int { return data}
    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.data == rhs.data
    }
    
    var data : Int
    var left : Node?
    var right : Node?
    var parent : Node? = nil
    var description: String {
        return String(data) + (left?.description ?? "") + (right?.description ?? "")
    }
    
    init(_ data: Int) {
        self.data = data
    }
    
    func insert(_ data: Int) {
        if (data < self.data){
            if let lhs = left {
                lhs.insert(data)
            }
            else {
                let lhNode = Node(data)
                lhNode.parent = self
                left = lhNode
            }
        }
        else {
            if let rhs = right {
                rhs.insert(data)
            }
            else {
                let rhNode = Node(data)
                rhNode.parent = self
                right = rhNode
            }
        }
    }
}

func leftMostChild(_ n: Node) -> Node? {
    var node = n
    while (node.left != nil) {
        node = node.left!
    }
    return node
}

func inorderSucc(_ node: Node? = nil) -> Node? {
    print (node?.data)
    if (node == nil) {
        // base case
        return nil
    } else {
        if let rhs = node?.right {
            return leftMostChild(rhs)
        } else {
            //
            var current = node
            var parent = node?.parent
            while (parent != nil && parent!.left != current) {
                current = parent
                parent = parent?.parent
            }
            return parent
        }
    }
}


func preorderSearch (_ node: Node, _ data: Int) -> Node? {
    if (node.data == data) {return node}
    else {
        if (data < node.data) {
            if let lhs = node.left {
                return preorderSearch(lhs, data)
            } else {
                return nil
            }
        }
        else
        {
            if let rhs = node.right {
                return preorderSearch(rhs, data)
            }
            else {
                return nil
            }
        }
    }
}
```

## BFS

```swift
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
```

## DFS
```swift
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

func dfsIterativeVals(_ node: Node) -> [Int]{
    var stack = [node]
    var outputArr = [Int]()
    var current : Node? = node
    while stack.count > 0 {
        while current != nil {
            stack.append(current!)
            current = current!.left
        }
        current = stack.popLast()
        if !stack.isEmpty {
            outputArr.append(current!.data)
        }
        current = current!.right
    }
    return outputArr
}
```

## AVL Trees
```swift
class Node: CustomStringConvertible {
    var description: String {
        return "self \(data) height: \(height), { { LC \(String(describing: left)) } { RC \(String(describing: right))) }  }"
    }
    
    var left : Node?
    var right: Node?
    var parent: Node?
    var height: Int = 0
    var data : Int
    
    init(_ val: Int) {
        self.data = val
    }

    func newNode(_ val: Int) -> Node {
        let node = Node(val)
        node.height = 0
        return node
    }
    
    func updateHeightUpwards(_ aboveNode: Node? = nil){
        var nodeInsp : Node? = aboveNode ?? self
        while let node = nodeInsp {
            let newHeight = max(node.left?.height ?? -1, node.right?.height ?? -1) + 1
            nodeInsp!.height = newHeight
            nodeInsp = node.parent
        }
    }
    
    // need a root node, unless we use a parent pointer
    // rotations return a node by definition, so insert needs to as well
    func insert(_ data: Int ) -> Node {
        if self.data > data {
            // lhs
            if let lft = self.left {
                lft.insert(data)
            } else {
                let newNode = self.newNode(data)
                newNode.parent = self
                self.left = newNode
                updateHeightUpwards(self.left)
            }
        } else {
            if let rgt = self.right {
                rgt.insert(data)
            } else {
                let newNode = self.newNode(data)
                newNode.parent = self
                self.right = newNode
                self.right!.parent = self
                updateHeightUpwards(self.right)
            }
        }
        
        if getBalance() > 1  { // unbalanced on the left
            if (left?.left?.height ?? -1 < left?.right?.height ?? -1  ) { // so unbalanced on the right
                let firstRotation = leftRotate(left) ?? self
                left = firstRotation
//                let secondRotation = rightRotate(self)
                updateHeightUpwards(self)
            }
            // left left case
            return rightRotate() ?? self
        }

//        // right right case
        if getBalance() < -1 { // unbalanced on the right

            if ( right?.left?.height ?? -1 > right?.right?.height ?? -1 ) { // so unbalanced on the left
                print ("right left UNFINISHED - totes unchecked")
                let firstRotation = rightRotate(right) ?? self
                right = firstRotation
                updateHeightUpwards(self)
            }
            // right right case
            return leftRotate() ?? self
        }

        return self
    }
    
    func delete(_ data: Int) {
        var toRemove : Node? = nil
        if data == self.data {
            // remove the root
            toRemove = self
        } else {
            var toCheck : Node? = nil
            if (self.data > data) {
                toCheck = self.left
            } else {
                toCheck = self.right
            }
            while let node = toCheck {
                if (node.data == data) {
                    toRemove = node
                    break
                } else {
                    if (node.data > data) {
                        toCheck = node.left
                    } else {
                        toCheck = node.right
                    }
                }
            }
        }
        
        if let rmv = toRemove {
            if (rmv.left == nil && rmv.right == nil) {
                // remove the child node, and update the nodes above
                if let par = rmv.parent {
                    if (par.left?.data == rmv.data) {
                        par.left = nil
                        par.height  = max(par.left?.height ?? -1, par.right?.height ?? -1) + 1
                        updateHeightUpwards(par)
                    }
                    if (par.right?.data == rmv.data) {par.right = nil
                        par.height  = max(par.left?.height ?? -1, par.right?.height ?? -1) + 1
                        updateHeightUpwards(par)
                    }
                    // update the nodes above
                }
            }
            else {
                if (rmv.left == nil) {
                    rmv.parent?.right = rmv.right
                    updateHeightUpwards(rmv.right)
                    // update the nodes above
                } else if (rmv.right == nil) {
                    rmv.parent?.left = rmv.left
                    updateHeightUpwards(rmv.left)
                    // update the nodes above
                    
                } else {
                    // find sucessor to the node and replace
                    if let succ = sucessor(rmv) {
                        rmv.data = succ.data
                        rmv.right = succ.right
                        print (rmv.data)
                        rmv.height = max(rmv.left?.height ?? -1, rmv.right?.height ?? -1) + 1
                        // update the nodes above
                        updateHeightUpwards(rmv)
                    }
                }
            }
        }
    }
    
    func sucessor(_ node: Node) -> Node? {
        if let rightChild = node.right {
            return rightChild
        }
        var parent = node.parent
        var child = node
        while let prnt = parent {
            if parent?.left?.data == child.data {
                return parent
            }
            child = prnt
            parent = prnt.parent
        }
        
        return nil
    }
    
    
    func balance () -> Node? {
        // left left case
        //        if getBalance() > 1
        return nil
    }
    
    func isBalanced() -> Bool {
        if getBalance() > 1 || getBalance() < -1 {
            return false
        }
        return true
    }
    
    func getBalance () -> Int {
        return (left?.height ?? -1) - (right?.height ?? -1)
    }
    
    func rightRotate(_ atNode: Node? = nil) -> Node? {
        // The unbalanced node becomes the right child of its left child
        let current = atNode ?? self
        let y = Node(current.data)
        y.left = nil
        y.right = current.right
        y.parent = current.parent

        let x = current.left
        

        if let t2 = x?.right {
            y.left = t2
            t2.parent = y
        }

        if let xNode = x {
            xNode.right = y
            y.parent = xNode
            xNode.height = max(x?.left?.height ?? -1, x?.right?.height ?? -1) + 1

        }
        
        // update the heights
        y.height = max(y.left?.height ?? -1, y.right?.height ?? -1) + 1
        return x ?? nil
    }
    
    func leftRotate(_ atNode: Node? = nil) -> Node? {
        let current = atNode ?? self

        let x = newNode(current.data)
        x.left = current.left
        x.right = nil

        let y = current.right
        
        if let t2 = y!.left {
            x.left = t2
            t2.parent = x
        }
        
        y?.left = x
        x.parent = y

        
        // update the heights
        x.height = max(x.left?.height ?? -1, x.right?.height ?? -1) + 1
        y?.height = max(y!.left?.height ?? -1, y!.right?.height ?? -1) + 1
        
        return y ?? nil
    }

}
```
