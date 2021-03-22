## Swift: Using BFS for LeetCode problems

This relates to the Medium Post

 <https://medium.com/@stevenpcurtis.sc/swift-using-bfs-for-leetcode-problems-82696faf58d8?postPublishedType=repub>
![Small BST](https://github.com/stevencurtis/BFSForLeetCode/blob/master/Images/BSTSmall.png)

**Why**

Breadth-first search for trees can seem easy, but this can be expanded to be used for simple matrices, and this is often used for LeetCode challenges which are rated as Medium or above.

**Prerequisites:**

- Be able to create a binary tree, using insertions (although a simple implementation is shown below)

**Terminology**

- Tree: A data structure with a root value and left and right subtrees
- Matrix: A grid to store data
- Cell: One of the elements of a matrix

**The tree version**

![Levels BST](https://github.com/stevencurtis/SwiftCoding/blob/master/LeetCode/SwiftUsingBFSforLeetCodeProblems/Images/BSTSmallLevels.png)

Traversing the tree above involves passing through the three levels in turn (it does not matter the order of the nodes within the level, and the nodes are presented left-to-right here although any order would be acceptable)
Level 0-10
Level 1- 5, 20
Level 2- 3,15
A sample implementation (and test) is in the Gist here:
	
```swift
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

```
	
The implementation here revolves around creating a queue that is appended to iff there is a left or a right subtree.

It is trivial to convert this into path length.
	
**The Matrix version**

LeetCode 1091. Shortest Path in Binary Matrix requires us to work out the shortest path (from the top-right hand corner to the lower-right hand corner) of a matix (represented by [[Int]] in Swift). Cells in the grid can either be available (0) or blocked (1).

We could conceivably choose a depth-first search, but that would involve going trough ALL of the possibilities first and picking the shortest one.

The added complexity from the matrix version includes the following:

- There are 8 directions that can be traveled in the matrix, and we need to make sure that we do not cross over the bounds of the grid.
- We need to confirm if each cell is possible to visit (has been blocked (1), or we mark it as visited (also 1)
- We will know if we have reached the goal (the bottom-right cell) by comparing the cell with the size of the grid (headCoordinate.0 == grd.count — 1 && headCoordinate.1 == grd.count — 1)
- Since each cell can have up to 8 paths from it, we need to make sure that for each iteration we pull up each path from the current cell — and perhaps this is the most complicated part of the full implementation

**Making the code easier to read***

By separating out the possible directions from the rest of the code we can split this out into a variable:
	
```swift
let dir:[[Int]] = [[0,1],[0,-1],[1,0],[-1,0],[1,-1],[-1,1],[-1,-1],[1,1]]
```

let dir:[[Int]] = [[0,1],[0,-1],[1,0],[-1,0],[1,-1],[-1,1],[-1,-1],[1,1]]
So we can calculate the candidate next coordinate by adding these to the current coordinate. One way of doing this is:
	
```swift
let nextCoordinate = (currentCoordinate.0 + direction[0], currentCoordinate.1 + direction[1])
```

**Algorithm**

So the basic idea goes like this:
We set the initial cell as the start (top-left hand corner; 0,0)
Set the path count to be 1
We take the elements in the queue, and for each current cell:
	
- Check if we can traverse to the cell (check it is 0), if not move to the next element
- Check we are at the destination. If we are, return the path count
- Mark the current cell as 1
- Then for each possible direction, calculate the nextCoordinate. If it is within the bounds add to the queue
- The current iteration is complete, increment the path count

After we have completed all of the possible cells, there is no solution so we return -1

The code snippet:
	
```swift
	let dir:[[Int]] = [[0,1],[0,-1],[1,0],[-1,0],[1,-1],[-1,1],[-1,-1],[1,1]]
	func shortestPathBinaryMatrix(_ grid: [[Int]]) -> Int {
	    guard grid.count > 0 else {return 0}
	    
	    var grd = grid
	    var coords : [(Int,Int)] = [(0,0)]
	    var count = 1
	    
	    while !coords.isEmpty {
	        let numberThisTurn = coords.count
	        for _ in 0..<numberThisTurn {
	            let currentCoordinate = coords.remove(at: 0)
	            if grd[currentCoordinate.0][currentCoordinate.1] == 1 {continue}
	            if currentCoordinate.0 == grd.count - 1 && currentCoordinate.1 == grd.count - 1 {
	                return count
	            }
	            grd[currentCoordinate.0][currentCoordinate.1] = 1
	            for direction in dir {
	                let nextCoordinate = (currentCoordinate.0 + direction[0], currentCoordinate.1 + direction[1])
	                
	                if nextCoordinate.0 >= 0 && nextCoordinate.1 >= 0 && nextCoordinate.1 < grd.count && nextCoordinate.0 < grd.count {
	                    coords.append(nextCoordinate)
	                }
	            }
	        }
	        count += 1
	    }
	    return -1
	}
	
print (
    shortestPathBinaryMatrix([[0,1],[1,0]]) // 2
)

print (
    shortestPathBinaryMatrix([[0,0,0],[1,1,0],[1,1,0]]) // 4
)

print (
    shortestPathBinaryMatrix([[0,0,0],[1,1,0],[1,1,1]]) // -1
)

print (
    shortestPathBinaryMatrix([[0,0,0],[0,1,0],[0,0,0]]) // 4
)
```
**Why not get in contact with me?**

<https://twitter.com/stevenpcurtis>
