import UIKit



let array: [Any] = [42, "Hello, world!", 12.34, true, CGFloat.pi]

for item in array {
    print(item)
}


//let items: [Any] = [42, "Hello, world!", 12.34, true, CGFloat.pi]
//for item in items {
//    if item == 42 { // Error
//        print("Found 42!")
//    }
//}


func findEqualItem<T: Equatable>(in array: [T], to value: T) -> Bool {
    return array.contains(value)
}

let numbers: [Any] = [1, 2, 3, 4, 5]
if findEqualItem(in: numbers, to: 3) {
    print("Found 3!")
}

enum Item {
    case wholeNumber(Int)
    case word(String)
    case number(Double)
}
