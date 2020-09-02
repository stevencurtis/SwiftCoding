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