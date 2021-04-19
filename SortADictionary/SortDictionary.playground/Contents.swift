import UIKit

var str = "Hello, playgrounds"
print(str)

var dictionary: [String: Int] = [:]

let names = ["Arjun", "Tisha", "Zaara","Bob", "Kasia", "Natalia", "Colin", "Noah", "Liya", "Sergey", "Kasia", "Natalia", "Colin", "Noah", "Liya", "Sergey", "Noah", "Liya"]

for name in names {
    dictionary[name, default: 0] += 1
}

print(dictionary)

let sortedDictionary: [Dictionary<String, Int>.Element] = dictionary.sorted(by: { $0.value > $1.value })


// This will error
// sortedDictionary["Colin"]
