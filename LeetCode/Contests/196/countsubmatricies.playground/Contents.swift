import UIKit

class Solution {
    func numSubmat(_ mat: [[Int]]) -> Int {
        let n = mat.count
        let m = mat[0].count
        var matrix = mat
        var res = 0
        for i in 0..<n {
            for j in 0..<m {
                if (matrix[i][j] == 1) {
                    var minval = j > 0 ? 1 + matrix[i][j - 1] : 1
                    matrix[i][j] = minval
                    res += matrix[i][j]
                    var k = i - 1
                    while (k >= 0 && (minval > 0) ) {
                        minval = min(minval, matrix[k][j])
                        k -= 1
                        res += minval
                    }
                }
            }
        }
        return res
    }
}
