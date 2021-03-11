import UIKit


// missingArrayElement



//let array = ["a", "b", "c", "d"]
//print(array[4])



// getForthElement
//let array = ["a", "b", "c", "d"]
//func getForthElement(arr:[String]) -> String? {
//    guard (array.count >= 4) else {return nil}
//    return arr[3]
//}
//getForthElement(arr: array)
//
////getNthElement
//func getNthElement(n: Int, arr:[String]) -> String? {
//    guard (array.count > n) else {return nil}
//    return arr[n]
//}
//getNthElement(n: 3,arr: array)


// indicies.contains
//let array = ["a", "b", "c", "d"]

//if array.indices.contains(3) {
//    print (array[3])
//}

//let sliceOfArray = array[1...3]
//print (sliceOfArray) // ["b","c","d"]
//slice[0]

//startIndexendIndex
//let target = 1
//
//if target >= sliceOfArray.startIndex && target < sliceOfArray.endIndex {
//    print(array[target])
//}


let array = ["a", "b", "c", "d"]
let sliceOfArray = array[1...3]


// arrayGetElement
//extension Array {
//    func getElement(at index: Int) -> Element? {
//        let isValidIndex = index >= 0 && index < count
//        return isValidIndex ? self[index] : nil
//    }
//}
//
//array.getElement(at: 1)


//extension Collection {
//    subscript(test: Index) -> Element? {
//        return indices.contains(test) ? self[test] : nil
//    }
//}
//
//sliceOfArray[test: 0]

// subscriptCollection
extension Collection {
    subscript(index i : Index) -> Element? {
        return indices.contains(i) ? self[i] : nil
    }
}



sliceOfArray[index: 0]

