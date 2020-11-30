import UIKit

class Solution {
    func minimumDeviation(_ nums: [Int]) -> Int {
        var maxOdd = 0
        for i in nums {
            var j = i
            while j % 2 == 0 {
                j = Int(floor(Double(j / 2)))
            }
            maxOdd = max(maxOdd, j)
        }
        var dev: [(Int, Int)] = []
        for i in nums {
            // i is odd
            if i % 2 == 1 {
                if 2 * i > maxOdd {
                    dev.append((2 * i - maxOdd, maxOdd-i))
                } else {
                    dev.append((Int.max, maxOdd - 2 * i))
                }
            } else {
                // i is even
                if i < maxOdd {
                    dev.append((Int.max, maxOdd - i))
                } else {
                    var j = i

                    while j % 2 == 0 && j > maxOdd {
                        j = j / 2
                    }
                    if j < maxOdd {
                        dev.append((2 * j - maxOdd, maxOdd - j))
                    }
                }
            }
        }
        dev.sort{$0>$1}
        if dev.count == 0 {return 0}
        var maxDown: [Int] = Array(repeating: 0, count: dev.count)
        var cur = 0
        for i in 0..<maxDown.count {
            cur = max(cur, dev[i].1)
            maxDown[i] = cur
        }
        var mn = (min(maxDown.last!, dev[0].0))
        for i in 0..<maxDown.count - 1 {
            if dev[i + 1].0 != Int.max {
                mn = min(mn, (maxDown[i] + dev[i + 1].0))
            }
        }
        return Int(mn)
    }
}

let sol = Solution()

print (
    sol.minimumDeviation([1,2,3,4])
) // 1
