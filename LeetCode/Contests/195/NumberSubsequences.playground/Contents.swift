import UIKit

class Solution {
    let MOD = 1000000007
    func numSubseq(_ nums: [Int], _ target: Int) -> Int {
        var result = 0
        
        // calculate the number of subsequences in an array of length i
        // which is 2 to the power of the length
        var powPreComp = Array(repeating: 0, count: nums.count + 1)
        powPreComp[0] = 1
        for i in 1..<nums.count {
            powPreComp[i] = 2 * powPreComp[i - 1] % MOD
        }

        // sort the array
        let arr = nums.sorted()
        
        // set the lowest point and the highest point as the longest possible subarray
        var low = 0
        var high = nums.count - 1
        
        while low <= high {
            let total = arr[low] + arr[high]
            
            if total > target {
                high -= 1
            } else {
                // The combination of sub sequence starting from nums[left] is 2 ^ (right - left)
                result += powPreComp[high - low]
                low += 1
            }
        }
        return result % MOD
    }
}
