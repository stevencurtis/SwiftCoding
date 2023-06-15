# The @State Property Wrapper
## Mutable state in SwiftUI

Although I've labeled this article as beginner, I've noticed that my previous article about [property wrappers](https://stevenpcurtis.medium.com/swiftuis-property-wrappers-a8771e8ef39b) just didn't make it seem so. So I think it really asks for a new article about the @State property wrapper.

Difficulty: **Beginner** | Easy | Normal | Challenging

# Prerequisites:
[Be able to produce a "Hello, World!" SwiftUI iOS application](https://stevenpcurtis.medium.com/hello-world-swiftui-92bcf48a62d3)

# Terminology
Property Wrapper: A property wrapper adds a layer of separation between code that manages how a property is stored and the code that defines a property
@State: a property wrapper used to create a single source of truth for data in your app which mutates over time (and updating a view appropriately).

# The @State property wrapper
In Swift, a struct is used to store variables of different data types and views are simple structs.

This leads us to a problem. This problem is that a view struct does not have a mutating function where you can change it's properties. This means that `@State` is a solution to this issue, as it can be used to manage mutable state in SwiftUI in the `view` struct.

By annotating a property with `@State` we communicate to Swift that SwiftUI can manage this property in shared storage. Put simply, that means that SwiftUI will automatically re-render a view that is dependent on that property as necessary. When the state changes, SwiftUI knows to redraw or "recompose" the view.

*All this is better shown with an example (as usual).*

Before I go into detail I'll show the easiest example. A `isButtonPressed` property annotated as `@State` correctly marked with private as the access control (since `@State` properties are generally accessible by a single `view`).

```swift
@State private var isButtonPressed = false
```

Note that `@State` properties are usually initialized with a default value for the initial render of a view. Subsequent to this the value is managed by SwiftUI and persists across view updates, so `@State` properties should not be accessed in a view's initializer.

# The example
So we have a property to represent the (for want of a better word) state of a button. This means that we can re-render the button label to represent whether the button is pressed or not.
The following code would certainly work, and I feel represents the use of `@State` adequately.

```swift
import SwiftUI

struct ContentView: View {
    @State private var isButtonPressed = false

    var body: some View {
        Button(action: {
            isButtonPressed.toggle()
        }) {
            Text(isButtonPressed ? "Button is pressed" : "Button is not pressed")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```

Each time the button is pressed the property would change, forcing a re render of the view and button. Smart!

# Notes to remember regarding @State
`@State` properties are usually be declared as private because each view should manage its own state. Other views have no business reaching into a view and changing it's state.
Any `@State` property should not be accessed from inside a `View`'s initializer. This is because the initial value is not fully established until after the initializer runs.
`@State` is designed to work with value types (`struct`s and `enum`s), not reference types (classes). When you change a value type, you're actually creating a new copy of the original. SwiftUI is able to track these changes and automatically update the UI.

# Conclusion
That isn't actually too tricky! Of course, re rendering according to state has pitfalls. If you start sharing state between views that is asking for problems, or even modifying the property from outside the view. As I come to think about it, state should be used only when necessary and immutable state used in lieu wherever possible.
