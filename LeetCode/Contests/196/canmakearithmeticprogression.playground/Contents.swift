import UIKit

class Solution {
    func canMakeArithmeticProgression(_ arr: [Int]) -> Bool {
        guard arr.count > 2 else {return true}
        let std = arr.sorted()
        let prevDiff = abs(std[0] - std[1])
        for i in 1..<(arr.count - 1) {
            let nextDiff = abs(std[i] - std[i + 1])
            if nextDiff != prevDiff {return false}
        }
        return true
    }
}
