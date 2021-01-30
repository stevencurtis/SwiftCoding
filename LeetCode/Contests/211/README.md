# LeetCode Weekly Contest 211 Swift solutions
## Graphs and stuff

![photo-1558021212-51b6ecfa0db9](Images/photo-1558021212-51b6ecfa0db9.png)
<sub>Siora Photography @siora18</sub>

This article is about the 4 challenges in the LeetCode Weekly Contest 211. That is

1624 Largest Substring Between Two Equal Characters<br>
1625 Lexicographically Smallest String After Applying Operations<br>
1626 Best Team With No Conflicts<br>
1627 Graph Connectivity With Threshold<br>

The solutions may assume some knowledge of Big O notation

## The Problems
Each problem will be approached in turn, with a solution and also with articles explaining the tools, techniques and theory that will help you solve these problems yourself.

Let us get started!

## 1624 Largest Substring Between Two Equal Characters
Given a particular string, the task is to return the longest substring between any two equal characters (excluding the matching Characters in question). If there is no such match `-1` should be returned.

If we traverse the array, we populate a dictionary with characters and the first instance of that particular `Character` is recorded (that is, the index of the particular `Character` is recorded) and then we record the largest difference in indicies.

The use of a [Dictionary](https://medium.com/@stevenpcurtis.sc/dictionary-in-swift-52b14d6cfa93) means that lookups can be performed in O(n).

```swift
class Solution {
    func maxLengthBetweenEqualCharacters(_ s: String) -> Int {
        let arr = Array(s)
        var dict: [Character: Int] = [:]
        var maxVal = -1
        for ch in 0..<arr.count {
            if dict[arr[ch]] == nil {
                dict[arr[ch]] = ch
            }
            else {
                maxVal = (max(maxVal, ch - (dict[arr[ch]] ?? 0) - 1))
            }
        }
        return maxVal
    }
}
```

## 1625 Lexicographically Smallest String After Applying Operations
Given a `String` with even length (consisting wholly of digits from 0 to 9), return the lexicographically smallest `String` such that the following conditions are met -

One of two operations can be preformed - either:
*add digit `a` to all the odd-indicies of the String ([modulo arithmetic](https://medium.com/@stevenpcurtis.sc/the-swifts-remainder-operator-and-mod-a1cf17836cb7) applies).
*Rotate the `String` by `b` positions.

It is important to get the basic functions correct, meaning rotate is defined as follows:

```swift
func rotate(_ s: [Character], _ b: Int) -> String {
    var cs = s
    cs.append(contentsOf: cs[0..<b])
    cs.removeFirst(b)
    return String(cs)
}
```

and add which is created to add the digit:

```swift
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
```

now the code is put together with a 
[dfs implementation](https://github.com/stevencurtis/SwiftCoding/tree/master/SwiftUsingDFSforLeetCodeProblems).

It would help at this point to see the whole solution:

```swift
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
```

Essentially this is performed as a modified DFS algorithm where we are performing the operations on each Character of the `String` and calculating which returns the smallest `String`. In this case the Lexicographically smallest is calculated simply as the value of the `String` in question. 

## 1626 Best Team With No Conflicts
Taking an array of scores (which are Integers) we imagine that they are scores of a game. A parallel array with ages is of the same length - meaning that scores[i] and ages[i] represents the age of the ith player.

The challenge asks us to choose a team with the largest sum of scores, providing the team does not have any player where a younger player has a higher score than an older player.

The solution involves using `Zip2Sequence` to attach the scores and ages. The resultant sequence is then sorted by ages in descending, and then traversed.

The answer is that as we go through the resultant sequence, with the comments below helping the reader:

```swift
class Solution {
    func bestTeamScore(_ scores: [Int], _ ages: [Int]) -> Int {
        // sort by ages (descending)
        let pairs: Zip2Sequence<[Int], [Int]> = zip(scores, ages)
        // sort by age
        let std = pairs.sorted{ first,second in
            if first.1 == second.1 {
                return first.0 > second.0
            }
            return first.1 > second.1
        }
        var answer = 0
        var memo = [0:-1]
        for i in 0..<std.count {
            let currentSquadScore = std[i].0
            memo[i] = currentSquadScore
            // traverse all of the values before i
            for j in 0..<i {
                // the age of the person at j is greater or equal than that at i (as it is sorted)
                // therefore compare the score if the score before is greater or equal to the current value (if it is less we can include it because if it is
                // less it can't invalidate the score (no conflict because the age is less!)
                if (std[j].0 >= std[i].0) {
                    // store the maximum score from taking the current score total
                    // from the memo
                    // or adding the previous memo added to the score
                    if let previousSquadScore = memo[j] {
                        memo[i] = max(memo[i]!, previousSquadScore + currentSquadScore)
                    }
                }
            }
            answer = max(answer, memo[i] ?? 0)
        }
        return answer
    }
}
```

## 1627 Graph Connectivity With Threshold
This solution uses the [Union Find](https://github.com/stevencurtis/SwiftCoding/tree/master/UnionFind) algorithm, and the particular implementation is written below:

```swift
class Solution {
    class UnionFind<T: Hashable & Comparable> {
        var index: [T: Int] = [:]
        private var size = [Int]()
        
        private var parent = [Int]()

        func addSet(_ element: T) {
            index[element] = parent.count
            parent.append(parent.count)
            size.append(1)
        }

        public func union(_ firstElement: T, and secondElement: T) {
          if let firstSet = setOf(firstElement), let secondSet = setOf(secondElement) {
            if firstSet != secondSet {
              if size[firstSet] < size[secondSet] {
                parent[firstSet] = secondSet
                size[secondSet] += size[firstSet]
              } else {
                parent[secondSet] = firstSet
                size[firstSet] += size[secondSet]
              }
            }
          }
        }
        
        private func setByIndex(_ index: Int) -> Int {
          if index != parent[index] {
            parent[index] = setByIndex(parent[index])
          }
          return parent[index]
        }
        
        public func setOf(_ element: T) -> Int? {
          if let indexOfElement = index[element] {
            return setByIndex(indexOfElement)
          } else {
            return nil
          }
        }        
         public func inSameSet(_ firstElement: T, and secondElement: T) -> Bool {
          if let firstSet = setOf(firstElement), let secondSet = setOf(secondElement) {
            return firstSet == secondSet
          } else {
            return false
          }
        }
    }
    
    func areConnected(_ n: Int, _ threshold: Int, _ queries: [[Int]]) -> [Bool] {
        let uf = UnionFind<Int>()
        for i in 1...n {
            uf.addSet(i)
        }
        
        for i in (threshold + 1)...n {
            var m = 1 // m is a multiple, start with 1
            while (i * m <= n) {
                uf.union(i, and: i * m)
                m += 1
            }
        }
        
        var result: [Bool] = []
        
        for query in queries {
            result.append(
                uf.inSameSet(query[0], and: query[1])
            )
        }
        return result
    }    
}
```

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis)
