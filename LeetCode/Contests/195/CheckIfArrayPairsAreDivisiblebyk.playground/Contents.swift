import UIKit

let num = -2
let k = 4
print (
    (num % k) + k,
    ((num % k) + k) % k
)

class Solution {
    func canArrange(_ arr: [Int], _ k: Int) -> Bool {
        var freq: [Int: Int] = [:]
        for num in arr {
            freq[((num % k) + k) % k, default: 0] += 1
        }
        for i in 1..<k {
            if (freq[i] != freq[k - i]) {
                return false
            }
        }
        return ( (freq[0] ?? 2) % 2) == 0
    }
}

let sol = Solution()
