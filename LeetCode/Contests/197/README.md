# LeetCode Weekly Contest 197 Swift Solutions
## That weekly contest!

This article is about the 4 challenges in the LeetCode Weekly Contest 195. That is
* 1512 Number of Good Pairs
* 1513 Number of Substrings With Only 1s
* 1514 Path with Maximum Probability
* 1515 Best Position for a Service Centre

[https://github.com/stevencurtis/SwiftCoding/tree/master/LeetCode/Contests/197](https://github.com/stevencurtis/SwiftCoding/tree/master/LeetCode/Contests/197)

The solutions assume some knowledge of [Big O notation](https://medium.com/@stevenpcurtis.sc/beginners-big-o-for-swift-developers-c1ca94f2520)

# The Problems
Each problem will be approached in turn, with a solution and also with articles explaining the tools, techniques and theory that will help you solve these problems yourself.

Let us get started!

## 1512 Number of Good Pairs
This solution requires familiarity with [Arrays](https://medium.com/@stevenpcurtis.sc/the-array-in-swift-d3e0fb04a0dd) and [Dictionary](https://medium.com/@stevenpcurtis.sc/dictionary-in-swift-52b14d6cfa93) in Swift as well as [Reduce](https://medium.com/@stevenpcurtis.sc/create-your-own-reduce-function-in-swift-e92b519c9659).

We are given an array of `Integer` called `nums`.

Look for the number of pairs where `nums[i] == nums[j]` and `i < j`/

Given an array like `[1,2,3,1,1,3]` we would output `4` since there are 4 pairs that conform to the specification, that is [0,3], [0,4], [3,4], [2,5]  so we match the pairs after the 'current' pointer.

This approach uses a [Dictionary](https://medium.com/@stevenpcurtis.sc/dictionary-in-swift-52b14d6cfa93) because of the fast `O(n)` lookup in Swift. 

The number of pairs is calculated through `(n * n -1) / 2` which works out the number of pairs from the number of occurrences in input `nums`; which makes sense - check the Math(s) at [http://mathforum.org/library/drmath/view/61212.html](http://mathforum.org/library/drmath/view/61212.html) if necessary

```swift
class Solution {
    func numIdenticalPairs(_ nums: [Int]) -> Int {
        var freq: [Int:Int] = [:]
        
        for num in nums {
            freq[num, default: 0] += 1
        }
        
        return freq.reduce(0, { initial,next  in
            let next = (next.value * (next.value - 1)) / 2
        return initial + next
        })
    }
}
```

## 1513 Number of Substrings With Only 1s
Before tackling this particular problem it is worth looking at a similar Medium porblem. 

### 5. Longest Palindromic Substring
We are asked to find the longest substring that is a palindrome for an input `String` s. 
To simplify the problem, a separate function used to determine if a substring is a palindrome.

Remember that [in Swift, converting to and from Strings](https://medium.com/@stevenpcurtis.sc/strings-and-characters-in-swift-behind-the-scenes-e29bdc4d23a6) is an expensive operation so that converting is done just once: `let strArray = Array(s)` and this prevents Time Limit Exceeded errors.

Now we run through each possible string at the beginning, and if we have a **Palindrome** for any particular beginning letter we don't need to check this start `Character` again.

```swift
class Solution {

// This solution means that we only convert the String once

func longestPalindrome(_ s: String) -> String {
    guard s.count > 0 else {return ""}
    guard s.count > 1 else {return s}
    
    // These can be set as 0, because there is at least a single character palindrome in s
    var maxStart = 0
    var maxEnd = 0
    var max = 0
    
    // We can subscript a single time
    let strArray = Array(s)
    
    // run through each possible starting String
    for firstInt in 0..<s.count {
        // the longest possible palindrome would be the end element (for each beginning character
        var lastInt = s.count - 1

        if max >= lastInt - firstInt {break}

        // needs to work for a single character palindrome
        while lastInt >= firstInt {
            if isPalindrome(s: strArray, first: firstInt, last: lastInt) {
                let newMax = lastInt - firstInt
                if newMax > max {
                    max = newMax
                    maxStart = firstInt
                    maxEnd = lastInt
                }
                // this is a palindrome, it must be the largest for
                // this particular start position
                break
            } else {
                lastInt -= 1
            }
        }
    }
    let start = s.index(s.startIndex, offsetBy: maxStart)
    let end = s.index(s.startIndex, offsetBy: maxEnd)
    return String(s[start...end])
}

func isPalindrome(s: [Character], first: Int, last: Int) -> Bool {
    if first == last {return true}
    guard first < last else {return false}
    guard last < s.count else {return false}
    var start = first
    var end = last
    while start < end {
        let firstChar = s[start]
        let lastChar = s[end]
        if firstChar != lastChar {
            return false
        }
        start += 1
        end -= 1
    }
    return true
}
}
```

This brings us back to **1513** - which is actually a similar problem. 
Differences? We need to understand that the calculation needs to be conform to a `modulo 10^9 + 7`. We can represent this in Swift with the following:
`let modulus = Int(pow(Double(10), Double(9)) + 7)`

Now we don't need to do a full palindrome - this counts if the substring is just made up of `1` - actually making this much simpler in execution!
```swift
class Solution {
func numSub(_ s: String) -> Int {
    let strArray = Array(s)
    var count = 0
    let modulus = Int(pow(Double(10), Double(9)) + 7)
    var i = 0
    while i < strArray.count {
        var localCount = 0
        var j = i
        while j < strArray.count && strArray[j] == "1" {
            localCount += 1
            j += 1
        }
        count += localCount * (localCount + 1)/2 % modulus
        if i == j {i += 1} else {i = j}
    }
    return count
}
}
```

## 1514 Path with Maximum Probability
This is a solution using [Dijkstra's algorithm](https://medium.com/swift-coding/dijkstras-algorithm-in-swift-488a184fb7a6), but because the links between the nodes are two-way unfortunately this results in a TLE error.

```swift
class Solution {
    
    class Node : CustomStringConvertible {
        // unique identifier required for each node
        var identifier : Int
        //var distance : Double = 0
        var edges = [Edge]()
        var visited = false
        var probability: Double = 0
        
        var description: String {
            var edgesString = String()
            edges.forEach{  edgesString.append($0.description)}
            return "{ Node, identifier: \(identifier.description) +  Edges: \(edgesString) + }"
        }
        
        init(visited: Bool, identifier: Int, edges: [Edge]) {
            self.visited = visited
            self.identifier = identifier
            self.edges = edges
        }
        
        static func == (lhs: Node, rhs: Node) -> Bool {
            return lhs.identifier == rhs.identifier
        }
    }
    
    class Edge {
        var from: Node // does not actually need to be stored!
        var to: Node
        
        var probability: Double
        var description : String {
            return "{ Edge, from: \(from.identifier), to: \(to.identifier), probability: \(probability) }"
        }
        init(to: Node, from: Node, weight: Double) {
            self.to = to
            self.probability = weight
            self.from = from
        }
    }
    
    class Graph {
        var nodes: [Node] = []
    }
    
    // Complete the quickestWayUp function below.
    func setupGraphwith(edges: [[Int]], succProb: [Double]) -> Graph {
        let graph = Graph()
        
        // create all the nodes
        // The first and last node need to be included, so need nodes from "to" and "from"
        let nodeNames = Set ( edges.map{ $0[0] } + edges.map{ $0[1]} )
        for node in nodeNames {
            let newNode = Node(visited: false, identifier: node, edges: [])
            graph.nodes.append(newNode)
        }
        
        // create all the edges to link the nodes
        for edge in edges.enumerated() {
            if let fromNode = graph.nodes.first(where: { $0.identifier == edge.element[0] }) {
                if let toNode = graph.nodes.first(where: { $0.identifier == edge.element[1] }) {
                    let forwardEdge = Edge(to: toNode, from: fromNode, weight: succProb[edge.offset])
                    fromNode.edges.append(forwardEdge)
                    
                    let backwardsEdge = Edge(to: fromNode, from: toNode, weight: succProb[edge.offset])
                    toNode.edges.append(backwardsEdge)
                }
            }
        }
        return graph
    }
    
    func longestPath (source: Int, destination: Int, graph: Graph) -> Double {
        let cN = graph.nodes.first{ $0.identifier == source }
        guard var currentNode = cN else {return 0}
        currentNode.probability = 1
        currentNode.visited = true
        var toVisit = [Node]()
        toVisit.append(currentNode)
        while (!toVisit.isEmpty) {
            
            let nd = toVisit.firstIndex{node in
                if node.identifier == currentNode.identifier {return true}
                return false
                }!
            toVisit.remove(at: nd)
            
            currentNode.visited = true
            // Go to each adjacent vertex and update the probabilty
            for connectedEdge in currentNode.edges {
                let prob = currentNode.probability * connectedEdge.probability
                if (prob > connectedEdge.to.probability) {
                    connectedEdge.to.probability = prob
                    toVisit.append(connectedEdge.to)
                    if (connectedEdge.to.visited == true) {
                        connectedEdge.to.visited = false
                    }
                }
            }
            currentNode.visited = true
            
            // take the highest probability vertex
            if !toVisit.isEmpty {
                currentNode = toVisit.max(by: { (a, b) -> Bool in
                    return a.probability < b.probability
                })!
            }
            if (currentNode.identifier == destination) {
                return currentNode.probability
            }
        }
        return 0
    }
    
    func maxProbability(_ n: Int, _ edges: [[Int]], _ succProb: [Double], _ start: Int, _ end: Int) -> Double {
        let graph = setupGraphwith(edges: edges, succProb: succProb)
        return longestPath(source: start, destination: end, graph: graph)
    }
}
```

## 1515 Best Position for a Service Centre
The problem is to find a position such that **the sum of the euclidean distances to all customers is a minimum**.

This algorithm narrows down an area using the recision delta - constantly improving the "guess" until a better answer is acheived. 

```swift
class Solution {
    
    // 10^-5
    let modulus: Double =  1 / (pow( (10), (5)) )
    
    func getMinDistSum(_ positions: [[Int]]) -> Double {
        var minVal = Double(Int.max)
        var x: Double = 50
        var y: Double = 50
        var delta: Double = 50
        var min_x = x
        var min_y = y
        
        while delta >= modulus {
            // reset the center for the searching area to (min_x, min_y), set delta to the incremental step 
            var i = x - delta
            while i <= x + delta {
                var j = y - delta
                while j <= y + delta {
                    let d = dist(positions: positions, x: i, y: j)
                    if d <= minVal {
                        minVal = d
                        min_x = i
                        min_y = j
                    }
                    j += delta / 20
                }
                
                i += delta / 20
            }

            x = min_x
            y = min_y
            delta /= 20
        }
        return minVal
    }
    
    func dist (positions: [[Int]], x: Double, y: Double) -> Double{
        var ans: Double = 0
        for p in positions {
            let d: Double = pow(Double(p[0]) - x, 2) + pow(Double(p[1]) - y, 2)
            ans += sqrt(d)
        }
        return ans
    }
    
}
```
# Conclusion
If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 

Feel free to sign up to my [newsletter](https://slidetosubscribe.com/embed/swiftcoding/)
