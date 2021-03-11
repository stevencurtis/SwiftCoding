let array = ["a","b","c","d"]
print (array)
print (array[0])
print (array[3])
//print (array[4])

//print (array.first!)


func getForthElement(arr: [String]) -> String? {
    guard (array.count >= 4) else {return nil}
    return arr[3]
}

getForthElement(arr: array)

let sliceOfArray = array[1...3]

let target = 1
if target >= sliceOfArray.startIndex && target < sliceOfArray.endIndex {
    print(array[target])
}

if sliceOfArray.indices.contains(4){
    print(sliceOfArray[4])
}

extension Array {
    func getElement(at index: Int) -> Element? {
        let isValidIndex = index >= 0 && index < count
        return isValidIndex ? self[index] : nil
    }
}

array.getElement(at: 1)
//sliceOfArray.getElement(at: 1)

extension Collection {
    subscript(index i: Index) -> Element? {
        return indices.contains(i) ? self[i] : nil
    }
}

sliceOfArray[index: 4]
