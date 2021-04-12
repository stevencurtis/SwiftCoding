//
//  main.swift
//  LeetCodeAnswers
//
//  Created by Steven Curtis on 12/03/2021.
//

import Foundation

class Solution {
    func minStartValue(_ nums: [Int]) -> Int {
        var start = 0
        var minVal = 0
        for value in nums {
            start += value
            minVal = min(start, minVal)
        }
        return abs(minVal) + 1
    }
}

//let sol = Solution()

//print(sol.minStartValue([-3, 2, -3, 4, 2])) // 5
//print(sol.minStartValue([1, 2])) // 1
//print(sol.minStartValue([1, -2, -3])) // 5
