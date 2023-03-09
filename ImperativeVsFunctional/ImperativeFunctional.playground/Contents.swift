import UIKit

let arr = [1, 2, 3, 4, 5]

var output: [Int] = []
for i in 0..<arr.count {
    output.append(arr[i] * 2)
}

let functionalOutput = arr.map { $0 * 2 }
