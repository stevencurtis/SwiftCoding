

## Group Anagrams

```swift
class Solution {
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        guard !strs.isEmpty else {return [[]]}
        var dict: [String: [String]] = [:]

        for str in strs {
            let sorted = String(str.sorted())
            dict[sorted, default: []] += [str]
        }
        return Array(dict.values)
    }
}
```

## Three sum

```swift
func threeSum(_ nums: [Int]) -> [[Int]] {
    guard nums.count >= 3 else { return [] }
    var sums : Set<[Int]> = []
    let numsS = nums.sorted()
    let total = 0

    for firstVal in 1..<nums.count - 1 {
        // for each value, try to find the two matching values
        
        var candLeft = firstVal - 1
        var candRight = firstVal + 1
        
        while candLeft >= 0 && candRight < numsS.count {
            let localTotal = numsS[firstVal] + numsS[candLeft] + numsS[candRight]
            if localTotal == total {
                sums.insert([numsS[firstVal], numsS[candLeft], numsS[candRight]])
                candLeft -= 1
            } else {
                if localTotal < total {
                    candRight += 1
                } else {
                    candLeft -= 1
                }
            }
        }
    }
    return Array(sums)
}
```

## Binary Search

```swift
func binarySearch (arr: [Int], target : Int) -> Int? {
    guard arr.count > 0 else {return nil}
    func binarySearch (_ arr: [Int], _ target : Int, _ lowerBound: Int, _ upperBound: Int) -> Int? {
        if lowerBound > upperBound {return nil}
        let mid = lowerBound + (upperBound - lowerBound) / 2
        if arr[mid] == target {return mid}
        if arr[mid] < target {
            return binarySearch(arr, target, mid + 1, upperBound)
        } else {
            return binarySearch(arr, target, lowerBound, mid - 1)
        }
    }
    return binarySearch(arr, target, 0, arr.count - 1)
}
```

## Merge sort

```swift
func mergeSort(_ inputArray: [Int]) -> [Int] {
    guard inputArray.count > 1 else {return inputArray}
    let midpoint = inputArray.count / 2
    let firstArr = Array(inputArray[0..<midpoint])
    let secondArr = Array(inputArray[midpoint..<inputArray.count])
    return merge( mergeSort(firstArr), mergeSort(secondArr) )
}

// merge assumes the input arrays themselves are sorted
func merge(_ arrOne: [Int], _ arrTwo: [Int]) -> [Int] {
    var result = [Int]()
    var firstArr = arrOne
    var secondArr = arrTwo
    while let fa = firstArr.first, let sa = secondArr.first {
        if firstArr.first! < secondArr.first! {
            result.append(fa)
            firstArr.removeFirst()
        } else {
            result.append(sa)
            secondArr.removeFirst()
        }
    }
    
    while let fa = firstArr.first {
        result.append(fa)
        firstArr.removeFirst()
    }
    
    while let sa = secondArr.first {
        result.append(sa)
        secondArr.removeFirst()
    }
    return result
}
```

## Quicksort
```swift
func quicksort(_ arr: [Int]) -> [Int] {
    if arr.count <= 1 {return arr}
    let pivot = arr.count / 2
    let fp = arr.filter{$0 < arr[pivot]}
    let equal = arr.filter{$0 == arr[pivot]}
    let lp = arr.filter{$0 > arr[pivot]}
    return  quicksort(fp) + equal + quicksort(lp)
}
```

## Reverse linked list
```swift
class ListNode {
    var val: Int
    var next: ListNode?

    init(val: Int) {
        self.val = val
    }
}

extension ListNode: CustomStringConvertible {
    var description: String {
        return "\(val)" + (next?.description ?? "")
    }
}

class Solution {
    func reverseList(_ head: ListNode?) -> ListNode? {
        if head == nil {return nil}

        var prevNode: ListNode?
        var nextNode: ListNode? = head

        while nextNode != nil {
            let temp = nextNode?.next
            nextNode?.next = prevNode
            prevNode = nextNode
            nextNode = temp
        }
        return prevNode
    }
}
```
