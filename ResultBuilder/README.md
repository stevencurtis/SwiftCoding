# Swift's Result Builders
## TupleViews and more!

Difficulty: **Beginner** | Easy | Normal | Challenging<br/>
This article has been developed using Xcode 14.2, and Swift 5.7.2

## Prerequisites:
You need to be able to code in Swift, perhaps using
[Playgrounds](https://medium.com/@stevenpcurtis.sc/coding-in-swift-playgrounds-1a5563efa089) and be able to use SwiftUI

## Terminology
@resultBuilder: An attribute that transforms a sequence of statements into a single combined value
TupleView: A View created from a swift tuple of View values
Tuple: A group of zero or more values represented as a single compound value
Type: A representation of the type of data that can be processed, for example Integer or String
Variadric parameters: A parameter for a function that accepts zero or more values of the specified type

# Result builders: The prerequisites
We need to understand a number of things to be able to fully understand 
## Tuples...from the beginning
I've already written about Tuples in [a previous article](https://stevenpcurtis.medium.com/tuples-in-swift-5ee9106283be) as they allow you to store multiple values in a single variable.

Something like `var person = ("Steve", 22)` will do it in code. As you can see two elements are stored in the property called `person`.

## TupleView (represents a view)
A [TupleView](https://developer.apple.com/documentation/swiftui/tupleview) is a concrete SwiftUI `View` type that stores multiple `View`.

It is used internally by SwiftUI when combining views but developers typically do not interact with this type directly.

However you *can* use a `TupleView` and you might create a `ContentView` that shows the Words "Hello" and "World" on two different lines as they are contained within a `VStack`.

```swift
struct ContentView: View {
    var body: some View {
        VStack {
            TupleView((Text("Hello"),Text("World")))
        }
    }
}
```

# A look at VStack
We can use `TupleView` and `@resultBuilder` to look at `VStack` (and how similar views) work under the hood. This also gives a first opportunity to look at result builders. 

A `VStack` vertically arranges child views. 

**ViewBuilder's role**
`ViewBuilder` is itself a result builder that allows the declarative syntax where views can be listed within such a view without needing separators. 

**TupleView**
`TupleView` holds multiple child views in such a way that they can be stored without knowing how many views there would be in advance.

In effect SwiftUI wraps the views in a `VStack` internally in order manage them as a single entity. Kind of an implementation detail, but good to know.

**In conclusion**
When you put multiple views inside a `VStack` the result builder allows you to do so without separators (actually sitting behind this is `ViewBuilder`). 
Essentially `ViewBuilder` transforms multiple views inside a `VStack` to a single view or a hierarchy of views.

# A result builder is *what* now?
A result builder is a type that defines a set of static methods to construct values from a sequence of components.

The point is to make code readable and to use a declarative style.

We can say that result builders enable a domain-specific language style of coding where code blocks get transformed into rich data structures.

## The HTML example
We can use result builder to construct HTML content in a "Swifty" way.

```swift
protocol HTMLElement {
    var render: String { get }
}

struct Div: HTMLElement {
    let content: String
    var render: String {
        return "<div>\(content)</div>"
    }
}

struct P: HTMLElement {
    let content: String
    var render: String {
        return "<p>\(content)</p>"
    }
}

struct A: HTMLElement {
    let href: String
    let content: String
    var render: String {
        return "<a href=\"\(href)\">\(content)</a>"
    }
}
```

There are a few ways you might render out the HTML. The simplest is perhaps `String` concatenation and might look something like:

```swift
let div = Div(content: "This is enclosed in div tags.")
let p = P(content: "This is enclosed in paragraph tags.")
let a = A(href: "https://www.example.com", content: "This is a link")

let htmlContentConcat = div.render + p.render + a.render
print(htmlContentConcat)
```

Which is *fine*. There is nothing *wrong* with this at all. However we can use domain-specific syntax which is offered by result builders as a way to define the content in a more Swifty way.

## Using functions and static methods
For simple examples we can use functions and static methods. However notice in this example we are forced to use separators for our list of HTML statements.

```swift
struct HTMLBasicBuilder {
    static func buildBlock(_ elements: HTMLElement...) -> String {
        return elements.map { $0.render }.joined()
    }
}

let htmlBuilder = HTMLBasicBuilder.buildBlock(
        Div(content: "This is enclosed in div tags."),
        P(content: "This is enclosed in paragraph tags."),
        A(href: "https://www.example.com", content: "This is a link")
)
```

In this instance though you can argue that functions and static methods work fine. We will come onto further advantages or result builders further into this article.

## A result builder
Using the content from above (the HTML stuff) we can construct a result builder that takes n elements and returns a String. We do not need to know how many HTML elements are used in advance because we  a variadic parameter.

In order to be a result builder we must satisfy the following two requirements

- It must be annotated with the `@resultBuilder` attribute, which indicates that it is intended to be used as a result builder type and allows it to be used as a custom attribute
- It must supply at least one static buildBlock result-building method

This gives us the following code:

```swift
@resultBuilder
struct HTMLBuilder {
    static func buildBlock(_ elements: HTMLElement...) -> String {
        return elements.map { $0.render }.joined()
    }
}
```

Which is then accessed through a utility function (which dies to SOC we keep separate from the result builder itself).

```swift
func createHTML(@HTMLBuilder _ content: () -> String) -> String {
    return content()
}
```

We can then use this `createHTML` function to generate our HTML code!

```swift
let htmlContent = createHTML {
    Div(content: "This is enclosed in div tags.")
    P(content: "This is enclosed in paragraph tags.")
    A(href: "https://www.example.com", content: "This is a link")
}
```

Which returns the following (if printed to the console):
```html
<div>This is enclosed in div tags.</div><p>This is enclosed in paragraph tags.</p><a href="https://www.example.com">This is a link</a>
```

Nice!

# The advantages of result builders

Result builders truly excel in complex scenarios. Let's delve into the abstract reasons why you might consider using result builders in your project.

**Declarative syntax**
I think one of the main advantages of result builders is using declarative syntax. This allows us to create readable and intuitive code.

**Conditional and Optional Building**
Result builders provide built-in methods to handle conditionals (buildEither(first:), buildEither(second:)) and optionals (buildOptional(:)). This makes it easier to conditionally include or exclude parts of the content based on certain conditions without breaking the flow of the DSL.

I'll cover this in an article about `ViewBuilder`

**Consistency**
We are able to craft code that looks great alongside SwiftUI code.

**Encapsulation**
With result builders, the logic for constructing the final output is encapsulated within the builder.

**Nested builders**
Result builders can be nested and this allows for complex structures to be build in a declarative manner.

# Conclusion

Phew. That's it for result builders for now. Helpful? I hope so!

