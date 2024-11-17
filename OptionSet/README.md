# Mastering OptionSet in Swift
## Simplifying Complex Sets of Options

`OptionSet` is a protocol that allows developers to represent a set of options in a type-safe way.
It might be used for representing combinations of values in scenarios where multiple options might apply simultaneously.
This article dives into what `OptionSet` is, how to use it, and examples of how it can simplify complex code involving sets of options.

# What is OptionSet?
A protocol that allows you to define a set of unique, discrete options that can be combined efficiently using bitwise operations. 

It is commonly used to represent configurations, permissions or status indicators where multiple values might be needed at once.

# What Use OptionSet?
OptionSet is potentially superiour to using multiple Bool flags as it is likely to provide clean code that is easy to read, maintain and build features on.

OptionSet is advantageous in scenarios where:
- There are multiple options that can apply simultaneously
- Managing multiple Boolean properties is too complex
- Memory efficiency is important

# Creating an OptionSet

```swift
struct TextStyleOptions: OptionSet {
    let rawValue: Int
    static let bold = TextStyleOptions(rawValue: 1 << 0)
    static let italic = TextStyleOptions(rawValue: 1 << 1)
    static let underline = TextStyleOptions(rawValue: 1 << 2)
    static let strikethrough = TextStyleOptions(rawValue: 1 << 3)
}
```

Option sets all conform to `RawRepresentable` by inheritance using the `OptionSet` protocol. Whether using an option set or creating your own, you use the raw value of an option set instance to store the instance's bitfield. The raw value must therefore be of a type that conforms to the `FixedWidthInteger` protocol, such as `UInt8` or `Int`.

In this case `rawValue` is an `Int`.
`.bold` has a `rawValue` of 1 (binary 0001).
`.italic` has a `rawValue` of 2 (binary 0010).
`.underline` has a `rawValue` of 4 (binary 0100).

With unique bits, you can combine multiple options without overlap. For example, combining `.bold` and `.italic` with `|` results in 0011 (decimal 3), which is a unique combination. Note that each number is a power of two, so the next values would be 8 and 16 respectively.

# Using an OptionSet
Using `OptionSet` simplifies managing multiple options in ways that standard `Bool` cannot. This approach ensures clean code, even as conditions become more complex.

```swift
var styles: TextStyleOptions = [.bold, .underline]

styles.insert(.italic)

if styles.contains(.bold) {
    print("Text is bold")
}

styles.remove(.underline)
```

When combining options the `rawValue` uses **bitwise OR** operations in order to set multiple bits within a single integer so multiple options can be represented at once.

The OR `|` operator sets a bit to 1 in if the bit in either operand is set to 1.

In this example `.bold` and `.italic` added is 3 (1 + 2 = 3, or 0001 + 0010 = 0011), as shown in the code above.

```swift
  0001
| 0010
------
  0011
```

# Real-World Examples in UIKit and SwiftUI

Apple extensively uses OptionSet within its frameworks. Some examples include:

**UIView.AnimationOptions**
Defines various animation options like .curveEaseIn and .allowUserInteraction that can be combined to customize animations.

**UIRectCorner**
Used to specify which corners to round, such as .topLeft and .bottomRight.

**SwiftUI's TextAlignmentOptions**
 Allows for combining text alignment options for text rendering.
 
These are highly effective uses of OptionSet that allow developers to customize behavior without manually tracking individual options.

# Best Practices for Using OptionSet
**Choose Powers of 2 for Unique Values**
Ensure that each option's raw value is a unique bit by using powers of 2 (1, 2, 4, 8, …). This allows safe bitwise operations.

**Use Descriptive Names**
Clearly name each option to improve readability. Since OptionSet allows for combining options, descriptive names prevent confusion.

**Limit OptionSet Size**
Avoid creating too many options in a single OptionSet as it can lead to confusion and makes code harder to read. Group related options when possible.

# Conclusion
Swift's `OptionSet` protocol is a robust tool for representing combinations of options, allowing for efficient and readable code. By structuring options this way, you streamline code, improve readability, and avoid the clutter of multiple `Bool`. Understanding and applying `OptionSet` can enhance code quality, especially when dealing with complex configurations, making it a powerful addition to any Swift developer's toolkit.
