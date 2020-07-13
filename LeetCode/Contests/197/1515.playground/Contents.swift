import UIKit

class Solution {
    
    // 10^-5
    let modulus: Double =  1 / (pow( (10), (5)) )
    
    func getMinDistSum(_ positions: [[Int]]) -> Double {
        var minVal = Double(Int.max)
        var x: Double = 50
        var y: Double = 50
        var delta: Double = 50
        var min_x = x
        var min_y = y
        
        while delta >= modulus {
            // reset the center for the searching area to (min_x, min_y), set delta to the incremental step delta/100
            var i = x - delta
            while i <= x + delta {
                var j = y - delta
                while j <= y + delta {
                    let d = dist(positions: positions, x: i, y: j)
                    if d <= minVal {
                        minVal = d
                        min_x = i
                        min_y = j
                    }
                    j += delta / 20
                }
                
                i += delta / 20
            }

            x = min_x
            y = min_y
            delta /= 20
        }
        return minVal
    }
    
    func dist (positions: [[Int]], x: Double, y: Double) -> Double{
        var ans: Double = 0
        for p in positions {
            let d: Double = pow(Double(p[0]) - x, 2) + pow(Double(p[1]) - y, 2)
            ans += sqrt(d)
        }
        return ans
    }
    
}
