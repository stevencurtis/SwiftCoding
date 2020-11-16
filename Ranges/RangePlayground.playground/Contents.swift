import UIKit

var str = "Hello, playground"
print (str)

let range : ClosedRange = 0...5
print (range) // 0...5
print(range.first) // Optional(0)
print(range.last) // Optional(10)

for index in range {
    print (index)
}

range.contains(4) // true
range.contains(8) // false

let people = ["Arjun", "Tisha", "Zaara","Bob", "Kasia", "Natalia", "Colin"]

print (people[range])

let basicRange: ClosedRange = 0...0
basicRange.isEmpty // false
basicRange.contains(0) // true

let halfRange: Range = 0..<4
let animals = ["Cat", "Dog", "Rabbit", "Fox", "Elephant", "Donkey"]
print (animals[halfRange]) // ["Cat", "Dog", "Rabbit", "Fox"]


let oneSidedRange: PartialRangeThrough = ...3
var cities = ["London", "Tokyo", "Delhi", "Shanghai", "Mexico City", "São Paulo", "Mumbai", "Cairo"]
print (cities[oneSidedRange]) // ["London", "Tokyo", "Delhi", "Shanghai"]
