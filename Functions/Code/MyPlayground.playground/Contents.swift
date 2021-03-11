import UIKit

var str = "Hello, playground"

let number = Int.random(in: 0 ... 10)

func writeNum() {
    print ( Int.random(in: 0 ... 10) )
}

writeNum()
writeNum()
writeNum()
writeNum()
writeNum()


func writeNum(name: String) {
    print (name)
    print ( Int.random(in: 0 ... 10) )
}
writeNum(name: "Dave")


func joinStrings(one: String, two: String) {
    print (one + two)
}
joinStrings(one: "a", two: "b")


func joinStringsAndReturn(one: String, two: String) -> String {
    return (one + two)
}
joinStringsAndReturn(one: "a", two: "b")

func myDiv(one: Int, two: Int) -> Int? {
    if two < 1 {return nil}
    return one / two
}
myDiv(one: 1, two: 0) // nil
myDiv(one: 4, two: 2) // 2


func myName(name nm: String) {
    print (nm)
}
myName(name: "Steve") // Steve

func sum(numbers: Int...){
    var sum = 0
    for i in numbers {
        sum += i
    }
    print (sum)
}
sum (numbers: 1,2,3)
sum (numbers: 1,2,3,4,5)

func calcInterest(money: Int, interestRate: Int = 0) -> Int {
    return money + (money * interestRate)
}
calcInterest(money: 1)
calcInterest(money: 2, interestRate: 1)


func addTwo(_ one: Int, _ two: Int) -> Int {
    return one + two
}

addTwo(2, 4)
