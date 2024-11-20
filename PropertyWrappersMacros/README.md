# Swift Property Wrappers vs. Macros
## A comparison of the tools

Swift gives developers powerful tools to streamline and simplify code. Two of these tools are property wrappers and macros that each give functionality to manage repetitive tasks and add custom behaviour.
Yet there are distinct purposes and use cases, and this article will explore the differences between them and when we might choose either of the tools.

# The Basic Differences
!(Images/basic.png)[Images/basic.png]

Let's deep-dive into this and get a clear approximation of the difference between these two tools.

# Property Wrappers
Property wrappers are custom types that add behaviour to properties by wrapping them into a reusable, encapsulated layer. This can be used to manage property-related logic like default values, validation or state management.
Essentially property wrappers make it easier to create consistent and reusable behaviours across multiple properties without repeating code.

## How Property Wrappers Work
A property wrapper is a struct, class, or enum that uses the `@propertyWrapper` attribute. The wrapped property is defined within this wrapper type, and any additional behavior or logic is encapsulated within the wrapper, rather than in the main property definition.

Here's an example of a property wrapper for clamping a number to a specified range:

```swift
@propertyWrapper
struct Clamped<T: Comparable> {
    private var value: T
    private let range: ClosedRange<T>

    init(wrappedValue: T, _ range: ClosedRange<T>) {
        self.range = range
        self.value = range.contains(wrappedValue) ? wrappedValue : range.lowerBound
    }

    var wrappedValue: T {
        get { value }
        set { value = min(max(newValue, range.lowerBound), range.upperBound) }
    }
}
```

This can be used by:

```swift
struct Example {
    @Clamped(0...100) var percentage: Int = 50
}

// Called with
var example = Example()
example.percentage = 120
print(example.percentage)
```

In this example, the `@Clamped` property wrapper ensures that percentage stays within 0 and 100, providing a reusable solution that can be applied to any property needing this behavior.

# Macros
Macros enable code generation at compile time, and are primarily used to reduce repetitive code by expanding predefined patterns when the program compiles.
Macros can add code anywhere, from function types to expressions.

## How Macros Work
Macros are created by defining a macro function, which tells the compiler how to transform specific code. Macros can take arguments and use those arguments to generate code. This is especially useful for boilerplate-heavy tasks like logging, custom debug descriptions, or generating property observers.

Here is my article on writing a macro, but if you already have a macro you can simply use the following code.

Here's an example using a macro `#AddLogging` that automatically adds print statements when a function is called:

```swift
#AddLogging
func calculateSum(a: Int, b: Int) -> Int {
    return a + b
}

// The compiler expands this to:
func calculateSum(a: Int, b: Int) -> Int {
    print("calculateSum called with a: \(a), b: \(b)")
    return a + b
}
```

## Comparing Property Wrappers and Macros
Now that we have a basic understanding of both tools, let's compare them on several key factors.

# Purpose and Use Cases
## Property Wrappers

Primarily designed to modify the behavior of individual properties. They are useful for managing common property logic, such as clamping values, lazy initialization, or dependency injection within properties.

## Macros
Intended for general code generation and can be applied broadly. Macros can automate repetitive tasks across functions, structs, classes, and even entire files. They are ideal for reducing boilerplate, generating custom debug information, or adding logging.

## Scope of Application
**Property Wrappers**
Limited to properties within classes, structs, or enums. Each property wrapper instance only affects the specific property it wraps.

**Macros**
Much more flexible and can operate on a wider variety of code elements, including types, functions, and expressions. This makes macros versatile for more complex or global code transformations.

## Compile-Time vs. Run-Time Behavior
**Property Wrappers**
Their behavior typically applies at runtime. For example, property wrappers like @State in SwiftUI affect how the property behaves as the app runs.

**Macros**
Macros are processed at compile time, meaning they expand into code before the app runs. This makes macros more efficient for tasks that don't need to be evaluated at runtime, such as adding logging or creating computed properties.

## Customization and Reusability
**Property Wrappers**
Highly customizable, as each property wrapper can hold custom logic and maintain internal state. This makes them highly reusable within properties across different types.

**Macros**
More general-purpose and focused on pattern-based code generation. While powerful, macros are often less specific than property wrappers and are intended for cases where you need the same transformation applied across multiple locations in your code.

## Readability and Code Clarity
**Property Wrappers**
Enhance readability when applied to properties. The wrapper syntax, such as @Clamped, makes it clear that specific behavior is applied to the property.

**Macros**
Macros can sometimes reduce readability, especially if they generate large blocks of code, as the expanded code is not immediately visible. However, for simple tasks like logging or debug information, macros can significantly improve code clarity by reducing clutter.

# When to Use Property Wrappers vs. Macros
## Use Property Wrappers
When you need to manage specific property behaviors, such as validation, default values, or dependency injection.
When behavior is unique to each property and doesn't require full compile-time expansion.

## Use Macros
When you need code generation that applies beyond just properties, such as adding logging, creating debug descriptions, or reducing boilerplate across functions and types.
When the transformation can be applied at compile time to reduce runtime overhead.

# Conclusion

While property wrappers and macros both reduce boilerplate and simplify code, they are distinct tools with different strengths. Property wrappers excel at encapsulating property-specific behaviors, while macros are ideal for compile-time code generation that spans broader contexts.
I hope this article has helped you out!
