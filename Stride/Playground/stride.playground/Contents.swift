import UIKit

// forLoopStride

//for i in 0..<10 {
//    print (i) // print 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
//}

//for i in stride(from: 0, to: 10, by: 1) {
//    print(i) // print 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
//}


// strideLargerthanone

//for i in stride(from: 0, to: 10, by: 2) {
//    print(i) // print 0, 2, 4, 6, 8
//}


// strideNegative

//for i in stride(from: 10, to: 0, by: -2) {
//    print(i) // print 10, 8, 6, 4, 2
//}


// stride non-integer

//for i in stride(from: 0.5, to: 9.75, by: 1.5) {
//    print(i) // print 0.5, 2.0, 3.5, 5.0, 6.5, 8.0, 9.5
//}

// stride through to

for i in stride(from: 0, through: 5, by: 1) {
    print (i) // print 0, 1, 2, 3, 4, 5
}

for i in stride(from: 0, to: 5, by: 1) {
    print (i) // print 0, 1, 2, 3, 4
}




class Solution {
    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        guard matrix.count > 0 else {return []}
        var minRow = 0
        var maxRow = matrix.count - 1
        var minCol = 0
        var maxCol = matrix[0].count - 1
        var output : [Int] = []
        
        while minRow <= maxRow && minCol <= maxCol {
            
            for j in minCol..<maxCol + 1 {
                output.append(matrix[minRow][j])
            }
            minRow += 1
            
            // 2. Downward
            for i in minRow..<maxRow + 1 {
                output.append(matrix[i][maxCol])
            }
            maxCol -= 1
            
            // 3. Leftward //<-&& rowLow <= rowHigh
            for j in stride(from: maxCol, through: minCol, by: -1) where minRow <= maxRow {
                output.append(matrix[maxRow][j])
            }
            maxRow -= 1
            
            for row in stride(from: maxRow, to: minRow - 1, by: -1) where minCol <= maxCol {
                output.append(matrix[row][minCol])
            }
            
            minCol += 1
            
        }
        return output
}
}
