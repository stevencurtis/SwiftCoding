# Breaking Down String Format Specifiers in Swift
## Format it well!

# Before we start
Difficulty: Beginner | **Easy** | Normal | Challenging<br/>
This article has been developed using Xcode 12.2, and Swift 5.3 

## Prerequisites:
* You will be expected to be able to run and use Swift's Playgrounds

## Keywords and Terminology:
String Format Specifiers: This article summarises the format specifiers supported by string formatting methods and functions.

Apple already have a [Strings Programming guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Strings/Articles/formatSpecifiers.html) for String Format Specifiers, but how are these actually used? In steps this guide

# Common formatting
##%d, %D
$d and %D represent a signed 32-bit Integer, that is an Int.

In the most basic case we can use the initializer for String to format the Integer

**Interpolate with %d**

```swift
let basicNumber: Int = 42
print(String(format: "%d", basicNumber)) // 42
print(String(format: "Basic Number: %d", basicNumber)) // Basic Number: 42
```

But we can do more with this initializer.

**Numbers before the decimal point**
```swift
let leadingZeros: Int = 5
let leadingStr1 = String(format: "%03d", leadingZeros) // 005
let leadingStr2 = String(format: "%05d", leadingZeros) // 00005
```

**Numbers after the decimal point**
```swift
let trailingZeros: Float = 7.9857
let trailingStr1 = String(format: "%.2f", trailingZeros) // 7.99
let trailingStr2 = String(format: "%.4f", trailingZeros) // 7.9857
```

**Convert from Integer to hex**
In C, %2X defines the field width - if the hex representation of the value consists of less than 2 digits a prefix will be appended and we are guaranteed to have a field width of 2.
```swift
let hexNumber: Int = 1616
let hexStr1 = String(format: "%2X", hexNumber) // 650
```

##%f
%f represents a 64-bit floating-point number, that is a double and it is printed in decimal notation.

**Interpolate with %f**

```swift
let doubleNumber: Double = 42.7
print(String(format: "%.1f", doubleNumber)) // 42.7
print(String(format: "Double Number: %.1f", doubleNumber)) // Double Number: 42.7
```

where the 1 represent rounding to 1 decimal place. Want 3 to make three decimal places?

```swift
let anotherDoubleNumber: Double = 12.345678
print(String(format: "%.3f", anotherDoubleNumber)) // 12.346
print(String(format: "Double Number: %.3f", anotherDoubleNumber)) // Double Number: 12.346
```

## %@
A string as returned by descriptionWithLocale if available, if not the description.

So this is a good one to think of as a String interpolation

**Interpolate with %@**

```swift
print(String(format: "Hello, %@.", "World")) // Hello, World
```

## %1...
You can have multiple variables, and these are numbered in a fashion as follows:

**Interpolate with multiple parameters**
```swift
print(String(format: "99% of the %@ is accurate", "test")) // "991035662052f the (null) is accurate\nBut % is a reserved character?
```

## But % is a reserved character?
No problem! Escape it with %
```swift
print(String(format: "99% of the %@ is accurate", "test")) // 99% of the test is accurate
```

# Less Common formatting
##%u, %U, %D
Unsigned 32-bit Integer
```swift
print(String(format: "%u...%u", UInt32.min, UInt32.max)) // 0...4294967295
```

##%e
64-bit floating-point number, printed in scientific notation
```swift
print(String(format: "greatest %e", Double.greatestFiniteMagnitude)) // greatest 1.797693e+308
```

## %c
8-bit unsigned character (unsigned char)
```swift
print(String(format: "The first letter is: %c", "Ab".utf8.first!)) // The first letter is: a
```

## %C
16-bit unsigned character (unsigned char)
```swift
print(String(format: "The first letter is: %C", "你".utf16.first!)) // The first letter is: 你

// The following is therefore expected behaviour
print(String(format: "The first letter is: %c", "你".utf16.first!)) // The first letter is: \n
``` 

## %s
Null-terminated array of 8-bit unsigned characters

```swift
print(
    "Hello, world!".withCString {
        String(format: "%s", $0)
    }
) // Hello, world!
```

## %S 
Null-terminated array of 16-bit UTF-16 code units

```swift
print(
    "Hello, world!".withCString(encodedAs: UTF16.self) {
        String(format: "%S", $0)
    }
) // Hello, world!
```

## %p
Void pointer uses unsafe pointer to print the location (prefixed with 0x)
```swift
var text = "Hello, World!"
print(
    withUnsafePointer(to: &text) {
        String(format: "%p", $0)
    }
) // 0x1056089b0
```

# Conclusion
You might not use this feature of Swift everyday. That's the point in this article, though as it explains the usage of format specifiers and hopefully clears up one blind spot that developers might have.
I hope this article helps anyone who reads it!

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
