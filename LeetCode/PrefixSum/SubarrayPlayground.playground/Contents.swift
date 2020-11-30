import UIKit

class Solution {
    func subarraySum(_ nums: [Int], _ k: Int) -> Int {
        // create a memo, that will store the sum frequences
        var memo : [Int:Int] = [:]
        // this can be the "start" of a contigous array, therefore memo starts as 0
        memo[0] = 1
        var prefixSum: Int = 0
        var count: Int = 0
        // for each Int num in nums
        for num in nums {
            // update the prefixSum - the sum of all elements up tot this point
            prefixSum += num
            // update the count of continuous subarrays
            // if we already
            count += memo[prefixSum - k, default: 0]
            // update the memo
            memo[prefixSum, default: 0] += 1
        }
        return count
    }
}

let sol = Solution()

print(sol.subarraySum([1,2,3,4,2,1], 3)) // 3
