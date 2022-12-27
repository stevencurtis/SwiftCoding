# URLify Create A URL From A String in Swift
## Replace Spaces with %20

Difficulty: **Beginner** | Easy | Normal | Challenging<br/>

It's great to practice various challenges when improving your Swift code. This particular solution refers to a "two-pointer" solution - if you're interested I also cover it in another Medium article: https://stevenpcurtis.medium.com/leetcode-weekly-contest-195-swift-solutions-242864add325

One such puzzle is the following:

Write a method to replace all spaces in a String with '%20'. You may assume that the String has sufficient space at the end to hold additional characters, and that you are given the "true" length of the String. 

# Some Strings To Test
If I'm approaching a problem such as this, I might want to think about the tests that I would wish to run on my own solution.

```swift
Mr John Smith Mr%20John%20Smith
```

# A Simple Answer
If you wish to complete this challenge using inbuilt functions there really isn't anything stopping you using `replacingOccurences`.

I've put the code in a simple function, and come up with the following:

```swift
func replace(input: String) -> String {
    input.replacingOccurrences(of: " ", with: "%20")
}

replace(input: "Mr John Smith") // Mr%20John%20Smith
```

# AddingPercentEncoding
Swift helps us out here with the `addingPercentEncoding` 

```swift
func replaceWithPercentEncoding(input: String) -> String {
    input.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? input
}

replaceWithPercentEncoding(input: "Mr John Smith") // Mr%20John%20Smith
```

# Your Own Replace Loop

Unfortunately there is an idea behind this question that needs to be "understood" to solve this problem in the correct way. 

Let us look at the question again:

Write a method to replace all spaces in a String with '%20'.' You may assume that the String has sufficient space at the end to hold additional characters, and that you are given the "true" length of the String. 

The idea here is to use the input String only, using a buffer at the end of the loop which is "given" in the question.

So "Mr John Smith" has a trueLength of 13.

This is a classic *two pointer* problem. However we can effectively replace one of the pointers with `replaceSubrange`.

**replaceSubrange**
The solution might look like the following, which essentially replaces the space characters with the target "`%20`" symbol.

This isn't really in the *spirit* of the question, as we have to delete (using removeLast) the extra spaces at the end of the `String`.

```swift
func replaceSpaces(input: String, trueLength: Int) -> String {
    var output = input
    let numberSpaces = trueLength - input.count
    var readPointer = numberSpaces - 1
    while readPointer > -trueLength + numberSpaces - 1 {
        let char = (output[output.index(output.endIndex, offsetBy: readPointer)])
        if char == " " {
            output.replaceSubrange(
                output.index(
                    output.endIndex,
                    offsetBy: readPointer
                )..<output.index(
                    output.endIndex,
                    offsetBy: readPointer + 1
                ),
                with: "%20"
            )
            output.removeLast(2)
            readPointer -= 2
        }
        readPointer -= 1
    }
    return output
}

replaceSpaces(input: "Mr John Smith    ", trueLength: 13) // Mr%20John%20Smith
```

**replaceNewString**
We could create a new `String` to output the resultant `String`. This involves creating an all-new output `String` and that does not seem like a very space-efficient solution (to say the least!). Also converting a `String` to an array? Doesn't seem quite right to me.

```swift
func replaceNewString(input: String, trueLength: Int) -> String {
    var inputArray = Array(input)
    var output = ""
    let numberSpaces = input.count - trueLength
    var readPointer = 0
    while readPointer < trueLength {
        let index = input.index(input.startIndex, offsetBy: readPointer)
        let char = input[index]
        if inputArray[readPointer] == " " {
            output.append("%20")
        } else {
            output.append(char)
        }
        readPointer += 1
    }
    return output
}

replaceNewString(input: "Mr John Smith    ", trueLength: 13) // Mr%20John%20Smith
```

**two pointer solution**
This is more like it! 

The idea is rather than copy and insert the array, we use a read pointer (set initially at the end of the text) and a write pointer set at the end of the `String`. If we read (from the back of the `String`) a normal character, we write to it at the position of the write pointer, if it's a whitespace we write "02%".
Since we go from the back of the `String` we never overwrite good data.
However, nothing is for free.
In swift subscripting `String` is possible, but we can't easily write (yes, we can insert. But subscripts themselves are read-only).
My solution? Create an Array copy of the `String`. I'm sorry.

```swift
func replaceInsert(input: String, trueLength: Int) -> String {
    var output = Array(input)
    let numberSpaces = input.count - trueLength
    var readPointer = trueLength - 1
    var writePointer = input.count - 1
    while readPointer >= 0 {
        let readIndex = input.index(input.startIndex, offsetBy: readPointer)
        let char = (input[readIndex])
        if char == " " {
            output[writePointer] = "0"
            writePointer -= 1
            output[writePointer] = "2"
            writePointer -= 1
            output[writePointer] = "%"
        } else {
            output[writePointer] = char
        }
        writePointer -= 1
        readPointer -= 1

    }
    return String(output)
}

replaceInsert(input: "Mr John Smith    ", trueLength: 13) // Mr%20John%20Smith
```
Yeah, you could "Just" pass an array of characters in the function signature. Frequently, however, you're given the function signature at the beginning of such a challenge. Doesn't change much in the big scheme of things in any case.

# Phone Screens
Sometimes these type of questions are used as phone screens for larger companies, as the questions are now quite famous and are usable in many languages.

Fortunately (or unfortunately) many companies accept the use of Swift's inbuilt functions. Of course, this does not guarantee that candidates are of sufficient algorithmic quality - but I guess that is not of our concern as Swift programmers?

# Conclusion
Keeping skills up to date in the programming game is really important. Honestly, I've dragged up some code from 2018 and had a quick think about this type of code to write this article - and added some improvements from what I've learned in the intervening years.

So I hope this article has helped **you** in some way, and you enjoy coding.

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
