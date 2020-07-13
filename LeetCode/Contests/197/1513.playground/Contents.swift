import UIKit

class Solution {
func numSub(_ s: String) -> Int {
    let strArray = Array(s)
    var count = 0
    let modulus = Int(pow(Double(10), Double(9)) + 7)
    var i = 0
    while i < strArray.count {
        var localCount = 0
        var j = i
        while j < strArray.count && strArray[j] == "1" {
            localCount += 1
            j += 1
        }
        count += localCount * (localCount + 1)/2 % modulus
        if i == j {i += 1} else {i = j}
    }
    return count
}
}
