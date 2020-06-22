import UIKit

class Solution {
    func xorOperation(_ n: Int, _ start: Int) -> Int {
        // guard n > 1 else {return start}
        var sum = 0
        for i in 0..<n {
            sum = sum ^ ( start + (2 * i) )
        }
        return sum
    }
}
