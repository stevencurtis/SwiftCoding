//
//  main.swift
//  SwiftUsingDFSforLeetCodeProblems
//
//  Created by Steven Curtis on 16/11/2020.
//

import Foundation

class Solution {
    func findLexSmallestString(_ s: String, _ a: Int, _ b: Int) -> String {
        var res = s
        var visited = Set<String>()
        dfs(s, a, b, &visited, &res)
        return res
    }
    
    func rotate(_ s: [Character], _ b: Int) -> String {
        var cs = s
        cs.append(contentsOf: cs[0..<b])
        cs.removeFirst(b)
        return String(cs)
    }
    
    func add(_ s: [Character], _ a: Int) -> String {
        var cs = s
        cs = cs.enumerated().map({
            if $0.offset % 2 == 1 {
                return Character(String( (Int(String($0.element))! + a) % 10 ))
            }
            return $0.element
        })
        return String(cs)
    }
    
    func dfs(_ s: String, _ a: Int, _ b: Int, _ visited: inout Set<String>, _ res: inout String) {
        if visited.contains(s) {
            return
        }
        
        visited.insert(s)
        res = min(res, s)
        
        let cs: [Character] = Array(s)
        dfs(rotate(cs, b), a, b, &visited, &res)
        dfs(add(cs, a), a, b, &visited, &res)
    }
}

let sol = Solution()
print (sol.findLexSmallestString("5525", 9, 2)) // 2050


