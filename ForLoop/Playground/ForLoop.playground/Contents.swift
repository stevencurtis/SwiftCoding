import UIKit

let arr = ["a", "b", "c", "d"]

for letter in arr {
    print (letter)
}

for _ in arr {
    print ("element") // prints "element" for times
}


//fori02
//for i in 0...2 {
//    print (i) // prints 0, 1, 2
//}

for i in 0..<arr.count {
    print (arr[i])
}



//forevenswhere
for i in 0...5 where i % 2 == 0 {
    print (i) // prints 0, 2, 4
}
