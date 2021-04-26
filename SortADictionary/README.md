# Sorting a Dictionary Doesn't Make Sense
## Wait, you can?

![Images/rachel-o3tIY5pIork-unsplash.jpg](Images/rachel-o3tIY5pIork-unsplash.jpg)<br>
<sub>Photo by Rachel on Unsplash</sub><br>

Difficulty: Beginner | **Easy** | Normal | Challenging<br/>
This article has been developed using Xcode 12.4, and Swift 5.3.2

## Prerequisites: 
* You will be expected to be aware how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71) in Swift, or use [Playgrounds](https://medium.com/@stevenpcurtis.sc/coding-in-swift-playgrounds-1a5563efa089) to do the same
* You can see my previous article about [Swift's dictionaries](https://stevenpcurtis.medium.com/dictionary-in-swift-52b14d6cfa93)

## Terminology:
Dictionary: The association between keys and values (where all the keys are of the same type, and all values are of the same type)

# The Dictionary
A dictionary is a `struct` that provides fast access to the keys and values that it contains (great!). These might be known to you as hash tables or associated arrays if you are familiar with other languages. 

Now the *issue* is that although the order of a `Dictionary` is stable while you are using it (for example during a particular execution), a `Dictionary` does not have a predictable ordering.

That is, a `Dictionary` is not an ordered collection (specifically, of course it has an order by definition but it is not predictable in a way that you might use it).

So it doesn't make sense that you would want to *order* a `Dictionary`. Would it?

# I want to order a Dictionary
We've a rather unfortunate class at our school, where many of the names of the children are repeated multiple times within the class:
[Images/cdc-GDokEYnOfnE-unsplash.jpg](Images/cdc-GDokEYnOfnE-unsplash.jpg)<br>
<sub>Photo by CDC on Unsplash</sub><br>

You'd think that the school would not allow this, but never-mind.

The children are called:
"Arjun"
"Tisha"
"Zaara"
"Bob"
"Kasia"
"Natalia"
"Colin"
"Noah"
"Liya"
"Sergey"
"Kasia"
"Natalia"
"Colin"
"Noah"
"Liya"
"Sergey"
"Noah"
"Liya"

and these are placed in one of Swift's rather attractive arrays:
```
let names = ["Arjun", "Tisha", "Zaara","Bob", "Kasia", "Natalia", "Colin", "Noah", "Liya", "Sergey", "Kasia", "Natalia", "Colin", "Noah", "Liya", "Sergey", "Noah", "Liya"]
```

Now these can be placed into a dictionary to store the frequency of each name which is defined as:

```
var dictionary: [String: Int] = [:]
```

and we can traverse the names, and log the name as a key and store the frequency of that particular name.

```
for name in names {
    dictionary[name, default: 0] += 1
}
```

If we print the result, we get the following output:

```
["Noah": 3, "Liya": 3, "Tisha": 1, "Arjun": 1, "Zaara": 1, "Sergey": 2, "Natalia": 2, "Colin": 2, "Bob": 1, "Kasia": 2]
```

But wait, I would like this dictionary to be ordered according to the frequency (that is, the value associated with each key).

# I can't order a dictionary. What am I to do?
If we take an array, we can generally sort it. what if we try to do the same?

```
dictionary.sorted(by: { $0.value > $1.value })
```

gives us a rather pleasing result (when printed):

```
[(key: "Noah", value: 3), (key: "Liya", value: 3), (key: "Sergey", value: 2), (key: "Kasia", value: 2), (key: "Colin", value: 2), (key: "Natalia", value: 2), (key: "Arjun", value: 1), (key: "Bob", value: 1), (key: "Tisha", value: 1), (key: "Zaara", value: 1)]
```

which is exactly what we want. But this *isn't* a sorted array. It is, put simply, an array of Dictionary Elements:

```
let sortedDictionary: [Dictionary<String, Int>.Element] = dictionary.sorted(by: { $0.value > $1.value })
```

# A Dictionary.Element ?
Essentially the elements of the dictionary are represented by a tuple type that can be represented in an array. In the example above, the element is `Dictionary<String, Int>.Element`.

This is no longer a dictionary, and you can't subscript the elements of the array meaning that the following is not valid:

```sortedDictionary["Colin"]
```

# Conclusion
You can sort a `Dictionary`! Wait, a dictionary is unordered so you can't, and apparently sorting a `Dictionary` gives you a sorted array of the elements. This is subtly different, and an array of the `Dictionary` tuples is not a `Dictionary` unfortunately - although that may fit your needs enough to work as a proxy for a sorted dictionary.

Which is nice.

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 

