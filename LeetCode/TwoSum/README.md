# Two Sum and Three Sum


## Two sum

```swift
class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        for i in 0..<nums.count {
            let localTarget = target - nums[i]
            for j in 0..<nums.count {
                if i != j && nums[j] == localTarget {
                    return [i, j]
                }
            }
        }
        return []
    }
}
```

## Three Sum

```swift
func threeSum(_ nums: [Int]) -> [[Int]] {
    guard nums.count >= 3 else { return [] }
    var sums : Set<[Int]> = []
    let numsS = nums.sorted()
    let total = 0

    for firstVal in 1..<nums.count - 1 {
        // for each value, try to find the two matching values
        
        var candLeft = firstVal - 1
        var candRight = firstVal + 1
        
        while candLeft >= 0 && candRight < numsS.count {
            let localTotal = numsS[firstVal] + numsS[candLeft] + numsS[candRight]
            if localTotal == total {
                sums.insert([numsS[firstVal], numsS[candLeft], numsS[candRight]])
                candLeft -= 1
            } else {
                if localTotal < total {
                    candRight += 1
                } else {
                    candLeft -= 1
                }
            }
        }
    }
    return Array(sums)
}
```
