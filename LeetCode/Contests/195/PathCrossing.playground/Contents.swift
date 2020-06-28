import UIKit

class Solution {
    struct Pair: Hashable {
        var x: Int
        var y: Int
    }
    
    var directions: [UInt8: Pair] = [:]

    func isPathCrossing(_ path: String) -> Bool {
        directions[78] = Pair(x: 0, y: -1)
        directions[69] = Pair(x: 1, y: 0)
        directions[83] = Pair(x: 0, y: 1)
        directions[87] = Pair(x: -1, y: 0)
        
        var visited: Set<Pair> = [Pair(x: 0, y: 0)]
        var current = Pair(x: 0, y: 0)
        for ch in path {
            if let asciiValue: UInt8 = ch.asciiValue, let direction = directions[asciiValue] {
                current = Pair(x: current.x + direction.x, y: current.y + direction.y)
                if visited.contains(current) {
                    return true
                }
                visited.insert(current)
            }
        }
        return false
    }
}
