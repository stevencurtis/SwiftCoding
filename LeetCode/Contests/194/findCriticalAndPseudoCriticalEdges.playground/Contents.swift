import UIKit

class Solution {
    struct Edges: Hashable {
        var firstNode: Int
        var weight: Int
        var secondNode: Int
    }
    
    func findCriticalAndPseudoCriticalEdges(_ n: Int, _ edges: [[Int]]) -> [[Int]] {
        // ascending edge weight to find the minumum overall weight
        let sortedEdges = edges.sorted{a, b in
            return a[2] < b[2]
        }
        
        var positionDictionary: [(Edges): Int] = [:]
        
        // indicies must be returned in the initial order, so we store these edges and their order
        for e in 0..<edges.count {
            positionDictionary[(Edges(firstNode: edges[e][0], weight: edges[e][1], secondNode: edges[e][2]))] = e
        }
        
        // Calculate MST
        let minWeight = dist(n: n, edges: sortedEdges, edge: -1, exclude: -1)
        // Output Array
        var output: [[Int]] = [[],[]]
        
        // for each edge
        for e in 0..<sortedEdges.count {
            // we use the original (sorted index)
            let index = positionDictionary[(Edges(firstNode: sortedEdges[e][0], weight: sortedEdges[e][1], secondNode: sortedEdges[e][2]))]!
            if dist(n: n, edges: sortedEdges, edge: -1, exclude: e) > minWeight {
                output[0].append(index)
            } else {
                if dist(n: n, edges: sortedEdges, edge: e, exclude: -1) == minWeight {
                    output[1].append(index)
                }
            }
        }
        return output
    }
    
    // nodes, edges (ordered), chosen edge, exclude
    func dist(n: Int, edges: [[Int]], edge: Int, exclude: Int) -> Int {
        var parents: [Int] = Array(0...n)
        var cost = 0
        var count = 0
        if (edge != -1) {
            let pick = edges[edge]
            parents[pick[0]] = parents[pick[1]]
            cost += pick[2]
            count += 1
        }
        
        // for each edge
        for i in 0..<edges.count {
            // do not take into account the excluded edge
            if (i == exclude) {
                continue
            }
            let root1 = find(p: parents, j: edges[i][0])
            let root2 = find(p: parents, j: edges[i][1])
            if (root1 != root2) {
                parents[root1] = root2
                count += 1
                // the cost if the node is not part of the network
                cost += edges[i][2]
            }
        }
        if (count == n - 1)
        {
            return cost
        }
        else {
            return Int.max
        }
    }
    
    // basic union find
    func find(p: [Int], j: Int) -> Int {
        if(p[j] != j) {
            return find(p: p, j: p[j])
        }
        return j
    }
}
