# Sorting

## Sorting
Bubble sort - n2 memory 1[Medium](https://medium.com/@stevenpcurtis.sc/bubble-sort-in-swift-b82ceee653b0)
Insertion sort O(N2)- memory 1nsert the current element into the right place on the sorted side on the left<br>
```swift
func sort(_ arr: [Int]) -> [Int] {
    var outputArr = arr
    for i in 1..<arr.count {
        var sortedIndex = i
        while sortedIndex>=1 && outputArr[sortedIndex] < outputArr[sortedIndex-1] {
            outputArr.swapAt(sortedIndex, sortedIndex-1)
            sortedIndex -= 1
        }
    }
    return outputArr
}
```
Selection sort - n2 memory 1- select the next smallest item<br>

```swift
func sort(_ inputArray: [Int]) -> [Int] {
    var sortedArray = inputArray
    
    // for each element (increasing), swap it with the minimum element in the rest of the list
    for j in 0..<sortedArray.count {
        var minIndex = j
        // test in all elements after j to find the minimum
        for i in j..<sortedArray.count {
            if sortedArray[i] < sortedArray[minIndex] {
                minIndex = i
            }
        }
        if minIndex != j {
            sortedArray.swapAt(j, minIndex)
        }
    }
    return sortedArray
}
```
Merge sort- n log n - memory 1 <br>
```swift
func sort(_ arr: [Int]) -> [Int] {
    guard arr.count > 1 else {return arr}
    
    let midPoint = arr.count / 2
    
    let firstHalf = Array(arr[0..<midPoint])
    let secondHalf = Array(arr[midPoint..<arr.count])
    return merge(
        sort(firstHalf),
        sort(secondHalf)
    )
}

func merge(_ arrOne: [Int], _ arrTwo: [Int]) -> [Int] {
    var leftIndex = 0
    var rightIndex = 0
    var mergedArray = [Int]()
    while (leftIndex < arrOne.count && rightIndex < arrTwo.count) {
        if arrOne[leftIndex] < arrTwo[rightIndex] {
            mergedArray.append(arrOne[leftIndex])
            leftIndex += 1
        }
        else if arrOne[leftIndex] > arrTwo[rightIndex] {
            mergedArray.append(arrTwo[rightIndex])
            rightIndex += 1
        }
    }
    
    while (leftIndex < arrOne.count) {
        mergedArray.append(arrOne[leftIndex])
        leftIndex += 1
    }

    while (rightIndex < arrTwo.count) {
        mergedArray.append(arrTwo[rightIndex])
        rightIndex += 1
    }
    
    return mergedArray
}
```
Quick sort - n2 but average n log n - memory log n<br>

```swift
func sort (_ array: [Int]) -> [Int] {
    guard array.count > 1 else { return array }
    let pivot = array.count / 2
    let lessThan = array.filter { $0 < array[pivot] }
    let moreThan = array.filter { $0 > array[pivot] }
    let equal = array.filter { $0 == array[pivot] }
    return sort(lessThan) + equal + sort(moreThan)
}
```
Counting sort<br> - worst case o(n + r) - memory n + r
```swift
func countingSort(_ arr: [Int]) -> [Int] {
    guard (arr.count > 1) else {return arr}
    // for the sorted array
    var l = Array(repeating: 0, count: arr.max()! + 1)
    
    for j in 0..<arr.count {
        l[ arr[j] ] += 1
    }
    
    var output : [Int] = []
    for i in 0..<l.count {
        print (l[i])
        while l[i] > 0 {
            output.append( i )
            l[i] -= 1
        }
    }
    
    
    return output
}
```
Radix sort - n * k / d - memory n + 2d <br>
```swift
func sort(_ array: [Int]) -> [Int]{
    var arr = array
    let base = 10
    var digitPosition = 1
    for _ in 0...Int(arr.max()!.description.count) {
        var buckets = [[Int]](repeating: [], count: base)
        for number in arr {
            let remainder = number / digitPosition
            let numberDigit = remainder % base // base is 10
            buckets[numberDigit].append(number)
        }
        digitPosition *= base
        print (buckets)
        arr = buckets.flatMap {$0}
    }
    return arr
}
```
Binary insertion sort - I've not used before<br>
