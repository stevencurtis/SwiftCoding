# Can You Answer This Swift Dictionary Question?
## You should!

It pays to keep your skills fresh. Particularly when it comes to dictionaries in Swift.

This is because they're a store of key-value pairs and have that lovely fast lookup option.

# Let's look at a tricky Swift question

You might want to store data associated with an Integer identifier. You can perhaps store a name against these identifiers:

```swift
var peopleDict: [Int: String?] = [
    1: "John",
    2: "Jane",
    3: nil,
    4: "Bob"
]
```

which can then be accessed 

```swift
let nameForID1 = peopleDict[1] // "John"
```

which is of course an O(1) lookup.

# The question
What is the difference between the following two lines:

```swift
people[1] = nil
```

and

```swift
people.updateValue(nil, forKey: 1)
```

# people[1] = nil
This line takes the person at the first key position, and nils the value.

So after this operation we have the following result:

```swift
[4: Optional("Bob"), 2: Optional("Jane"), 3: nil]
```

# people.updateValue(nil, forKey: 1)
This line takes the key, and nils the value. After this operation (without having performed the operation above!)

gives the following output:

```swift
[4: Optional("Bob"), 2: Optional("Jane"), 3: nil, 1: nil]
```

# Why it's tricky
You need to know the difference between setting the value and key of a dictionary through assignment, and updateValue.

*Not the best interview question I've seen, but nevermind*

# Conclusion
Happy coding! I knew that you could answer this question, but thanks for reading anyway!
