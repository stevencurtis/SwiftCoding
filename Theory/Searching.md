# Searching

## Binary search
```swift
func binarySearch (arr: [Int], target : Int) -> Int? {
    guard arr.count > 0 else {return nil}
    func binarySearch (_ arr: [Int], _ target : Int, _ lowerBound: Int, _ upperBound: Int) -> Int? {
        print (lowerBound, upperBound)
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


```swift
func binarySearch <T:Comparable> (arr: [T], target : T) -> Int? {
    guard arr.count > 0 else {return nil}
    func binarySearch <T:Comparable> (_ arr: [T], _ target : T, _ range: Range<Int>) -> Int? {
        if range.lowerBound >= range.upperBound {return nil}
        let mid = range.lowerBound + (range.upperBound - range.lowerBound) / 2
        if arr[mid] == target {return mid}
        if arr[mid] < target {
            return binarySearch(arr, target, mid + 1..<range.upperBound)
        } else {
            return binarySearch(arr, target, range.lowerBound..<mid)
        }
    }
    return binarySearch(arr, target, 0..<arr.count)
}
```