import UIKit

//If let and switch statements as expressions
// Apple examples
//let isRoot = false
//let willExpand = false
//let count = 0
//let maxDepth = 0
//let bullet = isRoot
//&& (count == 0 || !willExpand) ? ""
//: count == 0 ? "- "
//: maxDepth <= 0 ? "▹ "
//: "▿ "
//
//let bullet =
//    if isRoot && (count == 0 || !willExpand) { "" }
//    else if count == 0 { "- " }
//    else if maxDepth <= 0 { "▹ " }
//    else { "▿ " }

struct Account {
    var balance: Double
}

let account = Account(balance: 500)

let status =
    if account.balance < 0 { "debt" }
    else if account.balance == 0 { "break even" }
    else { "Profit" }

print("Your account is in \(status).")


enum WeatherCondition {
    case sunny
    case cloudy
    case rainy
}

let weather = WeatherCondition.sunny

let advice =
    switch weather {
    case .sunny: "Feeling hot!"
    case .cloudy: "Oooooooh"
    case .rainy: "Don't forget your rain jacket"
    }

print("Today's advice: \(advice)")

func printStringLength(_ str: String?) {
    let length = str?.count ?? 0
    print("String length: \(length)")
}

printStringLength("Hello") // Prints "String length: 5"

let str: String? = nil
printStringLength(str) // In Swift 5.9, error occurs here as we are trying to pass a nil value to a function that expects a non-nil string


