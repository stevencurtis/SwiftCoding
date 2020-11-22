# LeetCode Weekly Contest 216 Swift solutions
## Surprisingly Easy

![photo-1504280539878-538b933c05b7](Images/photo-1504280539878-538b933c05b7.png)
<sub>Image by A Million Lanterns</sub>

This article is about the 4 challenges in the LeetCode Weekly Contest 216. That is

1662 Check If Two String Arrays are Equivalent<br>
1663 Smallest String With A Given Numeric Value<br>
1664 Ways to Make a Fair Array<br>
1665 Minimum Initial Energy to Finish Tasks<br>

The solutions assume some knowledge of Big O notation

## The Problems
Each problem will be approached in turn, with a solution and also with articles explaining the tools, techniques and theory that will help you solve these problems yourself.

Let us get started!

## 1662 Check If Two String Arrays are Equivalent
This task is worth three points - so we would not expect this to be too difficult. 

The question asks us it two arrays of `String` are equivalent when the constituent element of the `String` array are concatenated in order. 

That is
```swift
["ab", "c"] -> "abc", ["a", "bc"] -> "abc"
and since "abc" == "abc" we return true
```
In Swift, we are lucky in that we have a joined `func joined(separator: String = "") -> String` that gives us exactly the solution we are looking for.

```swift
class Solution {
    func arrayStringsAreEqual(_ word1: [String], _ word2: [String]) -> Bool {
        return word1.joined() == word2.joined()
    }
}
```

## 1663 Smallest String With A Given Numeric Value
Assume we can take the alphabet and assigning a 1-indexed value to each, therefore a = 1 and c = 3.

We are given the task of returning the smallest String with a length of `n`, and a numeric value of `k` (using the rubric above).

```swift
n = 3 and k = 27, and the output becomes "aay" since 1 + 1 + 25 = 27
```

This means that, effectively we want to add the largest possible character to the back of the answer String.

Taking a quick look through by own article about [Strings](https://medium.com/@stevenpcurtis.sc/strings-and-characters-in-swift-behind-the-scenes-e29bdc4d23a6) means we have a way of converting  `String(Character(UnicodeScalar(26 + 96)!))` which of course makes sense since in ASCII charts reveal `95 = a`.

```swift
class Solution {
    func getSmallestString(_ n: Int, _ k: Int) -> String {
        var result: String = ""
        var valuesLeft = k
        var characterPosition = n
        while characterPosition > 0 {
            if 26 + (characterPosition - 1) < valuesLeft {
                result.append(String(Character(UnicodeScalar(26 + 96)!)))
                valuesLeft -= 26
            } else {
                let poss = valuesLeft - characterPosition + 1
                result.append(String(Character(UnicodeScalar(poss + 96)!)))
                valuesLeft -= poss
            }
            characterPosition -= 1
        }
        return String(result.reversed())
    }
}
```

## 1664 Ways to Make a Fair Array
Given an array of Integers, where one element is removed from the array how many of arrays meet the condition evenElements == oddElements.

Rather than removing the elements in turn, and then calculating whether the odd numbers equal the even numers we can use the previous result to calculate the next one.

We can use `reduce` to calculate the initial odd and even number arrays.

```swift
var evenSum = nums.enumerated().reduce(0, {$0 + ( ($1.offset % 2) == 0 ? $1.element : 0) } )
var oddSum = nums.enumerated().reduce(0, {$0 + ( ($1.offset % 2) == 0 ? 0 : $1.element) } )
```

So if the element we wish to "remove" (although we are not actually removing anything), we remove the number from the relevant array:

```swift
if (num.offset % 2 == 0) {
    evenSum = evenSum - num.element
} else {
    oddSum = oddSum - num.element
}
```

we calculate whether the array meets the condition

```swift
if evenSum == oddSum { fairArrayCount += 1 }
```

and then return the element - but into position for the next iteration (so try to remove the next array element).

```swift
if (num.offset % 2 != 0) {
    evenSum = evenSum + num.element
} else {
    oddSum = oddSum + num.element
}
```

Here is the complete solution:
```swift
class Solution {
    func waysToMakeFair(_ nums: [Int]) -> Int {
        var evenSum = nums.enumerated().reduce(0, {$0 + ( ($1.offset % 2) == 0 ? $1.element : 0) } )
        var oddSum = nums.enumerated().reduce(0, {$0 + ( ($1.offset % 2) == 0 ? 0 : $1.element) } )
        var fairArrayCount = 0

        for num in nums.enumerated() {
            if (num.offset % 2 == 0) {
                evenSum = evenSum - num.element
            } else {
                oddSum = oddSum - num.element
            }
            
            if evenSum == oddSum { fairArrayCount += 1 }
            
            if (num.offset % 2 != 0) {
                evenSum = evenSum + num.element
            } else {
                oddSum = oddSum + num.element
            }
        }
        return fairArrayCount
    }
}
```

## 1665 Minimum Initial Energy to Finish Tasks
Given an array, each contains [a,b] where a = the energy required to finish a task and b = the energy required to start a task.

The LeetCode problem is to calculate the minimum amount of energy required to finish all of the tasks.

To do so, we sort the array into decreasing order of the difference between the energy required to finish the task and the the energy required to start the task.

```swift
let orderedTasks = tasks.sorted(by: {($0[1] - $0[0]) > ($1[1] - $1[0])})
```
we then work to calculate the required energy. For each task, If we don't enough energy for the current task we log the amount of energy that is required (over and above the current amount). We then caculate the current energy required, and of course return the amont of required energy.

```swift
class Solution {
    func minimumEffort(_ tasks: [[Int]]) -> Int {
        let orderedTasks = tasks.sorted(by: {($0[1] - $0[0]) > ($1[1] - $1[0])})
        var currentEnergy = 0
        var required = 0
        for ar in orderedTasks {
            let actual = ar[0]
            let minimum = ar[1]
            if currentEnergy < minimum {
                required += minimum - currentEnergy
                currentEnergy += (minimum - currentEnergy)
            }
            currentEnergy -= actual
        }
        return required
    }
}
```

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis)
