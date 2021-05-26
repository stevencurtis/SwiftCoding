# Pass The Swift Code Review: Dictionary Edition
## Succinct Swift Code

Difficulty: Beginner | Easy | **Normal** | Challenging<br/>
This article has been developed using Xcode 12.5, and Swift 5.4

# Prerequisites:
* Some knowledge of [Swift's Dictionaries](https://stevenpcurtis.medium.com/dictionary-in-swift-52b14d6cfa93) would be useful
* The answers here use the [Ternary Operator](https://stevenpcurtis.medium.com/the-ternary-operator-in-swift-6813bdafb694)
* [Control Transfer Statements](https://medium.com/swlh/control-transfer-statements-in-swift-637363b1b1f2) are used in the final solution
* [Higher-Order functions are used](https://betterprogramming.pub/mapping-in-swift-a6d6132a38af) in the final solution
* [Reduce is used](https://stevenpcurtis.medium.com/create-your-own-reduce-function-in-swift-e92b519c9659) in one of the functions

# Terminology
Dictionary: The association between keys and values (where all the )


# Let's go!
Writing production-ready code probably requires some quotation marks. I mean, I've passed the [Linter](https://stevenpcurtis.medium.com/installing-and-using-swiftlint-21df54f090a2) and managed to push code. Then I get a [code review](https://stevenpcurtis.medium.com/giving-feedback-to-programmers-abc3f39cf53c) that just consists of a question mark? 

Here is a way of passing that code review, even though you think your code is perfectly adequate in any case.

# Writing Succinct Code
I know, it's annoying. You have clear working code and it does not necessarily pass code review due to style (that isn't actually in your firm's style guide).

Be careful out there, we need to write great code. So we need to understand what this is.

# The Problem
There are a number of developers at an organization, and they are stored in a dictionary (which is a dictionary of Strings). Something exactly like the following:

```swift
let developers: [String: [String]] = [ "Mr": ["Lim"], "Mrs": ["Smith", "Abayomi"], "Miss": ["González"], "Ms": ["Johnson", "Wilson"], "Other": [] ]
```

What we would like to do, is create an array of Strings which can then be used in a `UITableView` or similar. That is, an output of the following:

```swift
["Ms Johnson", "Ms Wilson", "Mr Lim", "Other", "Miss González", "Mrs Smith", "Mrs Abayomi"]
```

where the order does not matter. 

# A GREAT Solution
So we need an array of Strings. No problem, we can traverse the dictionary, and if there aren't any values we put the key into the Array. If there are, we can append the key and value into the Array (for each possible value).

The code is, arguably, easier to read than a great explanation. That explanation isn't great so here is some easy to read code:

```swift
var result: [String] = []
for developerPair in developers {
    if developerPair.value.isEmpty {
        result.append(developerPair.key)
        continue
    }
    for developer in developerPair.value {
        result.append("\(developerPair.key) \(developer)")
    }
}
```

There is nothing *wrong* with this solution. However, it won't always pass code review. 

The reason - it's not as short as it might be.

# Reduce
We can reduce the developers into an Array of String.

```swift
developers.reduce(into: [String]()) { result, current in
   guard !current.value.isEmpty else { result.append(current.key); return }
    result.append(contentsOf: current.value.map { "\(current.key) \($0)" })
}
```

We are appending to the result Array as we go, and have [each element of the Dictionary](https://stevenpcurtis.medium.com/sorting-a-dictionary-doesnt-make-sense-10dd26f5c21) to deal with as we traverse the dictionary. Of course we need to map all of those lovely values to make sure each and every one has a key - no problem!

# map
To get the same answer we can use `map` and `flatmap`.

```swift
developers.map { element in
    return element.value.isEmpty ? ["\(element.key)"] : element.value.map { "\(element.key) \($0)" }
}.flatMap{$0}
```

so we map the developers dictionary. The logic is around the same as the code above, but makes use of the ternary operator to return an array of arrays. Then, of course, this needs to be `flatMap` into an array of Strings, which is duly done.

You'll notice that this hasn't been placed into the result array, this is partly because you can print the answer direct to the console (map return the String array in this case).

# flatMap ( I like this one )
We can (wait for it) SKIP A STEP. Calling map followed by flatMap seems like rather a waste of time. Therefore we can make this a little easier by seeing if there are any values for this element, if there aren't add the key if not add the key and the value (for each value mapped).

Here is a better explanation, the code:

```swift
developers.flatMap { element -> [String] in
    guard !element.value.isEmpty else { return [element.key] }
    return element.value.map { "\(element.key) \($0)" }
}
```

# Conclusion
Opinion, opinion, opinion. This is all about opinion. 

All of the code posted in this article work. They pretty much all work in similar ways. 

For some, this is all they need to know. Some are looking for the *correct* solution, and unfortunately that isn't what this article is about.

This article is about opinions, and thinking through solutions to problems. If you can do that, you are well on the way to becoming a great developer.

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis)
