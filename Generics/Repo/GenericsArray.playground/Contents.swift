import UIKit

let ageArray = Array([12,24,82])
print (ageArray)



















struct MyArray<T>: CustomStringConvertible {
    var description: String {
        return "\(elements)"
    }
    
    var elements = [T]()
    
    init(_ input: [T]) {
        self.elements = input
    }
}

var myArray = MyArray([1,2,3])
print (myArray)

//func printAnArray<T>(arr:[T]) {
//    print ("Your Array is:")
//    arr.map { print($0) }
//}

func printAnArray<T>(arr:[T]) {
    print ("Your Array is:")
    arr.forEach({ element in
        print (element)
    })
}

printAnArray(arr: [1,2,3,4,5])

func largestValue<T: Comparable>(_ first: T, _ second: T) -> T {
    return max(first,second)
}

largestValue(1, 2)
largestValue("a", "b")


func provideMultipleValues<T: Comparable, S: Comparable>(_ first: T, _ second: S) -> (T,S) { return (first,second) }
let is2EqualTo2Point6 = provideMultipleValues("a", 3)
