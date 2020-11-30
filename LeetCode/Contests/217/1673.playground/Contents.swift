import UIKit

class Solution {
    func mostCompetitive(_ nums: [Int], _ k: Int) -> [Int] {
        var result : [Int] = []
        for num in nums.enumerated() {
            while (!result.isEmpty &&
                    result.last! > num.element &&
                    ((result.count - 1) + nums.count - num.offset) >= k
            ) {
                //Once we found there is a smaller number we can replace the top element stack, we can do a pop operation until we cannot pop, so long as we have space left in the array
                result.removeLast()
            }
            if result.count < k {
                //   Push the new smaller element into the stack and go on up to k
                result.append(num.element)
            }
        }
        return result
    }
}
