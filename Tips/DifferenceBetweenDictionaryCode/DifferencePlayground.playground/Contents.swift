import UIKit

var people: [Int: String?] = [
    1: "John",
    2: "Jane",
    3: nil,
    4: "Bob"
]

print(people)
people[1] = nil
print(people)
people.updateValue(nil, forKey: 1)
print(people)
