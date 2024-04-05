import UIKit

let numbers = [1, 2, 3, 4, 5]
let initialValue = 0
let closureCombineAccumulatorAndElement: (Int, Int) -> Int = { accumulator, element in
    accumulator + element
}
let result = numbers.reduce(initialValue) { accumulator, element in closureCombineAccumulatorAndElement(accumulator, element)
}

let sum = numbers.reduce(0, { sum, number in sum + number })
// sum is 15


let transactions = [
    ("groceries", 120.0),
    ("utilities", 80.5),
    ("groceries", 30.0),
    ("entertainment", 200.0),
    ("utilities", 50.0),
    ("groceries", 70.0)
]

let totalSpentPerCategory = transactions.reduce(into: [String: Double]()) { totals, transaction in
    let (category, amount) = transaction
    totals[category, default: 0] += amount
}

let words = Set(["apple", "banana", "cherry", "date", "apple", "banana"])
let wordLengthSum = words.reduce(0) { $0 + $1.count }


struct Product {
    let name: String
    let price: Double
}

let inventory = [
    Product(name: "Keyboard", price: 99.99),
    Product(name: "Mouse", price: 49.99),
    Product(name: "Monitor", price: 199.99)
]

let totalInventoryValue = inventory.reduce(0) { $0 + $1[keyPath: \.price] }
