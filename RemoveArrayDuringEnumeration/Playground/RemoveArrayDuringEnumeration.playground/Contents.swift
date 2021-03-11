import UIKit

var str = "Hello, playground"

//var input = [1,2,3,1000]
var input = [1,1000,1001,1004,2000]

// 1
//var last = input.last!
//print (
//input.filter{ last - $0 <= 1000}
//)

// 2
//for value in input.enumerated().reversed() {
//for value in input.reversed().enumerated() {
//    if value.element - input.last! > 1000 {
//        input.remove(at: value.offset)
//    }
//}

// 3
//var last = input.last!
//input.removeAll(where: { ($0 - last > 1000 ) } )

// 4
var last = input.last!
while input[0] < last - 1000 {
    input.removeFirst()
}

print (input)
