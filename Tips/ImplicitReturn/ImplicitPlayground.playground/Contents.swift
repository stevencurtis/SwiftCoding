import UIKit

let arr = [1,2,3,4,5]

let a = arr.filter{ element in return element > 2 }
print (a)
let b = arr.filter{ element in element > 2 }
print (a)
let c = arr.filter{ $0 > 2 }
print (c)


arr.filter{ element in return element > 2 }
arr.filter{ element in element > 2 }
arr.filter{ $0 > 2 }

func helloToTheWorld() -> String {
    "Hello, World" // with or without return
}

helloToTheWorld()
