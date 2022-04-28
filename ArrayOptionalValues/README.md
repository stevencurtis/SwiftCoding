# Unwrap an Array of Optional Values Using Swift
## If we aren't interested in nil

## Keywords and Terminology
Array: an ordered series of objects which are the same type (article)
compactMap: Returns an array containing the non-nil results of calling the given transformation with each element of this sequence
[Force unwrapping](https://medium.com/r/?url=https%3A%2F%2Fstevenpcurtis.medium.com%2Favoiding-force-unwrapping-in-swift-6dae252e970e): A method in which an optional is forced to return a concrete value. If the optional is nil, this will cause a crash
Optionals: Swift introduced optionals that handle the absence of a value, simply by declaring if there is a value or not. An optional is a type on it's own! ([article](https://medium.com/p/ee63c3999e16))

## The opportunity
In this example there is an [Array](https://medium.com/r/?url=https%3A%2F%2Fstevenpcurtis.medium.com%2Farrays-an-essential-programming-data-structure-56b0798c861b) of Strings and nil, that is an array of optionals because some of the values are Strings and some are represented by nil.

```let arrayOfOptionals: [String?] = ["There", "Present", nil, "Not nil", nil, "Some"]
```
This is all fine - but what if you want to do something to each of these Strings using something like [Mapping](https://medium.com/@stevenpcurtis.sc/mapping-in-swift-a6d6132a38af) where we run the same function against every element in the array.
This can be written as:

```
let uppercaseArray = arrayOfOptionals.map{ $0?.uppercased() }
```

Now I'm not a big fan of the `optional question mark ?`, and the reason for that becomes apparent when we print out this `array` to the console (by running `print(uppercaseArray)`):

```[Optional("THERE"), Optional("PRESENT"), nil, Optional("NOT NIL"), nil, Optional("SOME")]
```
Oh my word! What a mess when printed to the console! What if I needed to present this data to the end user? This would be awful, right?

## Ignore nil with compactMap
We don't care about those `nil` values in this example, effectively we want rid of them. In order to do this we can use `compactMap`

**Zap those optionals**

The optionals can be eradicated from the array with `compactMap` with something like

```
let arrayWithNoOptionals: [String] = arrayOfOptionals.compactMap { $0 }
```

I have explicitly detailed the type here, but this can be removed when writing Swift (although it is a little less clear what the resulting `array` type is):

```
let arrayWithNoOptionals = arrayOfOptionals.compactMap { $0 }
```

Which gives us an `array` of (if we print out the resultant array with something like `print(arrayWithNoOptionals)`):

```
["There", "Present", "Not nil", "Some"]
```

which can then be used along with uppercase to only write those values in capital letters

```
let uppercased = arrayWithNoOptionals.map{ $0.uppercased() }
```

Which we can the write to the console (again, something like `print(uppercased)`). Which gives the expected result of:

```
["THERE", "PRESENT", "NOT NIL", "SOME"]
```
What's more, you know what - this could all be done in a single line. That's detailed in the video though!

## Conclusion

I hope you enjoyed that rather short article. Please do keep a look out for me, if you are interested in such articles in the future! Thank you!
Oh, and keep an eye out for articles on mapping, perhaps [this one](https://medium.com/r/?url=https%3A%2F%2Fbetterprogramming.pub%2Fmapping-in-swift-a6d6132a38af) - it might give you a good view of how mapping and compactMap might work in context.
If you've any questions, comments or suggestions please hit me up on [Twitter](https://medium.com/r/?url=https%3A%2F%2Ftwitter.com%2Fstevenpcurtis)
