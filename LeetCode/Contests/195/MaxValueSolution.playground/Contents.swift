import UIKit

class Solution {
    func findMaxValueOfEquation(_ points: [[Int]], _ k: Int) -> Int {
        var result = Int.min
        var right = 0
        var currentX = 0
        // for each possible left point (meaning we have the max) for each possible
        // coordinate
        for left in 0..<points.count - 1 {
            // The current result is for the left coordinate
            var currentResult = Int.min
            // if currentX is viable (from the previous X)
            if (currentX > left && currentX <= right) {
                // set the current result for this left
                 currentResult = points[currentX][0] - points[left][0] + points[left][1] + points[currentX][1]
            }
            // set the right pointer to the right of the previous
            // currentX, or to the right of the left pointer
            right = currentX + 1 > left ? currentX + 1 : left + 1
            
            // set up the while loop that will find the max currentResult for any particular right pointer
            // which matches the current left pointer
            // while the right is in bounds, and the question condition that xᵢ - xⱼ < k
            while (right <= points.count - 1 && points[right][0] - points[left][0] <= k) {
                // calculate the prospective result
                let prospectiveResult = points[right][0] - points[left][0] + points[left][1] + points[right][1]
                // if the prospectiveResult is larger than the currentResult
                if (prospectiveResult >= currentResult) {
                    // if we have a larger result, record it
                    currentResult = prospectiveResult
                    // record the right pointer as currentX
                    currentX = right
                }
                // slide the right pointer right
                right += 1
            } // end of while loop
            
            // record the largest result for this left - if it is larger than the current
            result = max(result, currentResult)
        }
        return result
    }
}
