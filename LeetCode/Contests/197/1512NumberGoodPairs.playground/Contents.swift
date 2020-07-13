import UIKit

class Solution {
    func numIdenticalPairs(_ nums: [Int]) -> Int {
        var freq: [Int:Int] = [:]
        
        for num in nums {
            freq[num, default: 0] += 1
        }
        
        return freq.reduce(0, { initial,next  in
            let next =  (next.value * (next.value - 1)) / 2
        return initial + next
        })
    }
}
