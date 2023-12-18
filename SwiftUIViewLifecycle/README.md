# The SwiftUI View Lifecycle
## Here is how the SwiftUI view lifecycle works

Difficulty: Beginner | Easy | **Normal** | Challenging<br/>
This article has been developed using Xcode 12.4, and Swift 5.7.2

## Prerequisites:
You need to be able to code in Swift, perhaps using
[Playgrounds](https://medium.com/@stevenpcurtis.sc/coding-in-swift-playgrounds-1a5563efa089) and be able to use SwiftUI

## Terminology
View: In SwiftUI a view is a protocol that defines a piece of user interface and is a building block for creating UI in SwiftUI

# Declarative SwiftUI
SwiftUI is a data-driven framework. That means that for SwiftUI views are a function of state rather than a sequence of events.

A view is bound to data as it's source of truth and then updates whenever the state changes. Views are functions that take in data binding as an argument.

This gives advantages to us as Swift moves away from massive view controllers. The interface is coupled with the data increasing readability and producing fewer lines of code.

This also has trade offs. We are moving away from the [familiar UIKit view drawing lifecycle](https://betterprogramming.pub/demystifying-the-view-drawing-cycle-fb1f7ac519f1) lifecycle so need to think about how things work in SwiftUI.

## The view protocol
Views in `SwiftUI` conform to the `View` protocol:

```swift
struct MyView: View { }
```

this gives a set of requirements that a view must fulfill, including defining a body computed property like in the following code snippet:

```swift
struct MyView: View {
    var body: some View { }
}
```

# The view lifecycle
In SwiftUI views are lightweight and transient. Unlike UIKit, views are recreated when their underlying data changes.

This means we need to think of the SwiftUI view lifecycle in a slightly different way than we might think of UIKit views.

## Creation
SwiftUI views are created using their initializers. 

I have an example of a `CustomInput` that allows a String to be changed in a subview and that change reflected back in the parent.

The view? It's this:

```swift
struct CustomInput : View {
    @Binding var text: String
    var name: String
    
    init(_ name: String, _ text: Binding<String>) {
        self.name = name
        self._text = text
    }
    
    var body: some View {
        TextField(name, text: $text)
    }
}
```

This can be then be used within a parent view in order to update an @State property. Something like the following:

```swift
struct ContentView: View {
    @State private var testString = "test"
    var body: some View {
        VStack {
            CustomInput("test", $testString)
        }
        .padding()
    }
}
```

Now, testString can be changed through the CustomInput view, and any changes will be reflected back in the ContentView. Which means we have initialized the view with a `String` and text `Binding` and actually used them in a SwiftUI view.

## Updating
As detailed above SwiftUI views are lightweight and are thrown away if the underlying data changes and recreated. 

*Identity*
The control mechanism for this updating of views is controlled using identity. This concept means SwiftUI decides according to the body of a view it's identity.

*Equality*
`EquatableView` is a protocol that a SwiftUI view may conform to  to in order to determine equality with another view.

You might like to use this protocol to potentially avoid unnecessary redraws.

Imagine you have a complex view that is computationally expensive to recreate. Essentially this conformance works exactly the same as [equatable](https://betterprogramming.pub/swifts-equatable-and-comparable-protocols-54811114a5cf) in the rest of Swift.

```swift
struct CustomView: View, Equatable {
    var data: SomeComplexData

    var body: some View {
        //...
    }

    static func ==(lhs: CustomView, rhs: CustomView) -> Bool {
        // Custom equality check
        return lhs.data.id == rhs.data.id
    }
}
```
Here is the (documentation)[
https://developer.apple.com/documentation/swiftui/equatableview].

*Performance*
Only diff changes are rendered to the screen that helps make SwiftUI performant. The use of equality (above) can limit unnecessary redraws.

You might also like to avoid placing expensive computations (definitely think network calls) in a view's body. Thinking about that, since SwiftUI relies of diff in the view hierarchy you can optimise redraws but ensure only relevant parts of the UI update in response to state changes. Relevant to this is making sure that views depend on the minimum amount of state possible which avoids unnecessary side-effects.

It's worth knowing that `LazyVStack` and `LazyHStack` only load views as they come on screen and this can improve scrolling performance.

You'll also cripple performance if you cause reference cycles using your views. This is possible since although views are value types they can capture reference types. The old solution of using `[weak self]` as necessary can avoid these issues.

*Parent views*
Changes in parent views can lead to the recompilation of child views.

- Dependency Propagation
A change in the state of a parent can trigger a redraw of the child's `body`.
If a parent's view body is recomputed and produces a new child view the child's body will be computed. If the child view's body is complex this can have negative performance impacts.

- Conditional Rendering
Parent views can render child view on some logic (or state). This means that the child views are only rendered under certain circumstances.

- Modifiers Impact
Modifiers applied to a parent view can propagate to child views. Of course this behaviour can be overridden with modifiers applied to the children. [note that common view modifiers change colour or fonts]

- Environment Values
Parent views can set environment values which are implicitly passed to child views. This allows for data to be shared down the view hierarchy without explicitly passing it though initialisers and is a great use of SwiftUI.

- Performance Considerations
Be mindful of your use of `EquatableView` to ensure views are updated when necessary, and also be aware of state dependencies.

- View Reparenting

*Identity*
SwiftUI uses the concept of identity to determine if 

## Modifiers and the View Lifecycle
Modifiers affect the view lifecycle by customising view appearance and behaviour

**Modifiers**
Modifiers can affect various aspects of a view, from its appearance to its interaction capabilities. For example, applying a `.blur()` modifier will change the view's appearance, while a `.gesture()` modifier can change its interaction behaviour.

**view wrapping**
This is the concepts of taking a view and wrapping around it with another view to modify it's behaviour. This can mean putting a view into another view and allows for a compositional approach to building user interfaces.

**performance**

SwiftUI tries to optimize performance by coalescing multiple modifiers wherever possible. For instance, if you apply multiple .padding() modifiers to a view, SwiftUI will attempt to combine these into a single modifier to reduce the view hierarchy's complexity.

## Lifecycle methods
SwiftUI provides us `.onAppear()` and `.onDisappear()` modifiers.
**.onAppear()**
This instance method adds an action to perform before the view appears. Therefore we can think of this as roughly analogous to UIKit's `viewWillAppear` function.

**.onDisappear()**
This instance method adds an action to perform after the view disappears. Therefore we can think of this as roughly analogous to UIKit's `viewDidDisappear` function.

** Modifiers and lifecycle methods**
Modifiers can also be used to hook into the view lifecycle. For instance, the `.onAppear()` and `.onDisappear()` modifiers allow you to execute code when a view appears or disappears, respectively.

```swift
Text("Hello, World!")
    .onAppear {
        print("The view has appeared")
    }
    .onDisappear {
        print("The view has disappeared")
    }
```

So in this code `onAppear` and `onDisappear` are both modifiers.

## Performance considerations
**Minimize view redraws**
Use `EquatableView` conformance to skip unnecessary redraws, so for complex views you can skip rather large performance penalties.

Cut state dependencies to avoid unnecessary redraws. In fact this should apply to any code you make in Swift.

**Lazy loading**
Use `LazyVStack` and `LazyHStack` appropriately. Since these views lazily load content scrolling performance can be preserved in complex views.

**Avoid expensive computations**
Rather than performing network calls or expensive computations in a view's body perform them in the background and then move to update the state of a view on completion.

If you have complex views consider using conditional views so they are only calculated in appropriate situations. Be mindful that modifiers applied to a parent view is propagated to child views.

**Eliminate reference cycles**
In iOS development we should always be careful to avoid reference cycles. A good use of `[weak self]` within view modifiers can avoid some of these [reference cycles](https://stevenpcurtis.medium.com/retain-cycles-and-memory-management-in-swift-ed4aefedb01a#:~:text=A%20retain%20cycle%20(also%20known,strong%20reference%20to%20Object%20B%20).

**Efficient data propagation**
Environment values are a great way to pass data down the view hierarchy without having to pass them through every level of the hierarchy manually. This can simplify your code and potentially improve performance.

**Testing and profiling**
Use the Xcode profiling tools to measure performance and improve the behaviour of your SwiftUI views, identify bottlenecks and optimize code.

## Common pitfalls and misconceptions
**The switch to declarative syntax**
SwiftUI uses declarative syntax. This means the UI should adjust to state rather than imperative coding practices. If you're coming from a UIKit background this can be rather tricky!

**Stateless views**
SwiftUI views are transient and stateless. They should be lightweight and be recomputed whenever the state on which they depend changes. Rather than expecting views to maintain state or hold onto resources you need to get used to this idea pretty quickly!

This encapsulates the wider point that we should not expect SwiftUI to behave exactly as UIKit does for all situations. It's unlikely to!

**Identity**
SwiftUI uses view identity to know when to use or reuse views. Using the wrong identity for objects can lead to unnecessary refreshes and unexpected behaviour. 

# Conclusion

I hope this article has helped someone out, and perhaps I'll see you at the next article?
