import UIKit

func joinStrings(addme: String, to str: inout String){
    str.append(addme)
}

var addToThis = "test"
joinStrings(addme: "me", to: &addToThis)

print (addToThis) // testme

func giveNumber() -> Int {
    return Int.random(in: 1..<100)
}

var counter = 0
func inc(num: Int) -> Int {
    counter += 1
    return num + 1
}
