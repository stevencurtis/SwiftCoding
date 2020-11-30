import UIKit

class Solution {
    func maximumWealth(_ accounts: [[Int]]) -> Int {
        var largestWealth = 0
        for customer in accounts {
            largestWealth = max(largestWealth, customer.reduce(0, +))
        }
        return largestWealth
    }
}
