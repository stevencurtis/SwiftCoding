import UIKit

// let myNum: Int? = 3

// let myNum: Int?
// let myNum: Int? = nil


//let myNum: Int? = 3
//print (myNum!)


//let myNum: Int? = nil
//print (myNum!)


//let myNum: Int? = nil
//if let num = myNum {
//    print (num)
//}

//let myNum: Int? = 3
//if let num = myNum {
//    print (num)
//}

//let myNum: Int? = 3
//print (myNum ?? 5)

//var myNum: Int! = 3
//print (myNum)

//struct Person {
//    var name: String
//}
//
//struct Dog {
//    var owner: Person?
//}
//
//let tommy = Dog()
//
//print (tommy.owner!.name)


struct Person {
    var name: String
}

struct Dog {
    var owner: Person?
}

var bear = Dog()

let prince = Person(name: "Dave")
bear.owner = prince

print (bear.owner!.name)
print (bear.owner?.name)
