import UIKit

class Solution {
    func minMoves(_ nums: [Int], _ limit: Int) -> Int {
        // a store for the left boundary of the cases for each num in nums, always at least 2 long
        // that is, the delta is the range of possible target values
        var memo: [Int] = Array(repeating: 0, count: 2 * limit + 2)
        // the length of the array
        let n = nums.count
        // for the first half of the array, as the second half is compared with n - 1 - i
        for i in 0..<n / 2 {
            // first element
            let a = nums[i]
            // second element
            let b = nums[n - 1 - i]
            // two moves more is the maxium possible moves here, would only need to perform this
            // for the first half of the array
            memo[2] += 2
            // add or subtract one move according to the 5 rules set out above
            memo[min(a, b) + 1] -= 1
            memo[a + b] -= 1
            memo[a + b + 1] += 1
            memo[max(a, b) + limit + 1] += 1
        }
        // create the result. The maximum would be a move for each number in the array
        // that is, replacing each number with a value from 1..limit for every case in the array
        var res = n
        
        var curr = 0
        // from 2 to 2 * limit, we accumulate the number of moves of all pairs to subtract or add
        for i in 2...2 * limit {
            curr += memo[i]
            // find the smallest
            res = min(res, curr)
        }
        // return the result
        return res
    }
}

let sol = Solution()

print (
    sol.minMoves([1,2,4,3], 4) // 1
)
