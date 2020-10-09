# ListFormatter: The Missing Documentation
## It's a little bit great

![Photo by Daniel Bosse on Unsplash](Images/0*u_dp385Nmhuw9JwP.jpeg)<br/>
<sub>Photo by Daniel Bosse on Unsplash<sub>

Difficulty: Beginner | **Easy** | Normal | Challenging

From iOS 13 Apple made a [ListFormatter](https://developer.apple.com/documentation/foundation/listformatter) available - but skimped rather on the documentation. 

This article has been developed using Xcode 12.0, and Swift 5.3

#Prerequisites:
* You will be expected to be aware how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71) in Swift, or use [Playgrounds](https://medium.com/@stevenpcurtis.sc/coding-in-swift-playgrounds-1a5563efa089) to do the same

#The problem to be solved
We have three names, and we wish to write these as a list separated with commas.

In Swift we have the 
```swift
let names = ["Livesh", "Romesh", "Chau", "Bella"]
```

and I would like a **sample output** of 

```swift
Livesh, Romesh, Chau, and Bella
```

So how can I achieve this?

There are two ways, I'll call one the old way, and one the ListFormatter way.

##The Old Way
I'll need to know how many elements there are in an Array, and process a new String. 

```swift
let names = ["Livesh", "Romesh", "Chau", "Bella"]

var originalNamesString = ""
for name in names.enumerated() {
    if name.offset == names.count - 1
    {
        originalNamesString.append("and \(name.element)")
        
    }
    else
    {
        originalNamesString.append("\(name.element), ")
    }
}
```
This is a little bit tricky, I'm checking to see if I'm at the end of the array and appending the correct element (whether it contains and or a comma) - it's all a little - shall we say, not ideal.

##The new way
If you're using iOS 13 onwards you can use the following:
```swift
let namesString = ListFormatter.localizedString(byJoining: names)
```

and that's it! That produces the output as expected

##Changing the locale
I'm currently in the UK and want to define my locale as such.
That's fine; ListFormatter has you covered!
In this example I'll set the locale as `en_GB`

```swift
let formatter = ListFormatter()
formatter.locale = Locale(identifier: "en_GB")

let ukNamesString = formatter.string(for: names)
print (ukNamesString ?? "")
```

Which prints the substantively different output as `Livesh, Romesh, Chau and Bella` (note that it is the final comma that is missing, and this is a function of the locale that I've picked!).

##Item formatter
There is a rather natty option we can use to create lovely lists. What about...

**Currency**

```swift
        let priceFormatter = NumberFormatter()
        priceFormatter.locale = Locale(identifier: "en_GB")
        priceFormatter.numberStyle = .currency
        
        let currencyListformatter = ListFormatter()
        currencyListformatter.itemFormatter = priceFormatter
        currencyListformatter.locale = Locale(identifier: "en_GB")
        
        let items = [1.3, 1.2, 9.4, 3.4]
        let currencyString = currencyListformatter.string(for: items)
        print (currencyString ?? "")
```
this outputs properly formatted currency in a list:

```swift
£1.30, £1.20, £9.40 and £3.40
```

Which in this case is £, since the currency chosen is `en_GB`.

**Dates**
Now we have learnt that trick, can we do the same with dates?

You certainly can!

```swift
let dateFormatter = DateFormatter()
dateFormatter.locale = Locale(identifier: "en_GB")
dateFormatter.dateStyle = .long

let dateListformatter = ListFormatter()
dateListformatter.itemFormatter = dateFormatter
dateListformatter.locale = Locale(identifier: "en_GB")

let dates = [Date(timeIntervalSince1970: 1821546354), Date(timeIntervalSince1970: 1221546354), Date(timeIntervalSince1970: 721546354)]
let datesString = dateListformatter.string(for: dates)
print (datesString ?? "")
```

This gives the following output:

```swift
21 September 2027, 16 September 2008 and 12 November 1992
```

Which is extremely nice.

# Conclusion
There are so many different formatters we can use, and using ListFormatter will allow you to produce readable Strings for your user which is of course nice.

Making things easer for the user? Isn't that why we all got into this game?

Thanks for reading!

 If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 