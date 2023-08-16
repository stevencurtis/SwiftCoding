# The @Binding property wrapper
## Two way binding

Although I've labeled this article as beginner, I've noticed that my previous article about [property wrappers](https://stevenpcurtis.medium.com/swiftuis-property-wrappers-a8771e8ef39b) just didn't make it seem so. So I think it really asks for a new article about the `@Binding` property wrapper.

The image? Books are bound, things are bound together. I guess that is the root of the meaning of `@Binding`, bit we will get there in this article if you just read on!

Difficulty: **Beginner** | Easy | Normal | Challenging

# Prerequisites:
Be able to produce a "Hello, World!" SwiftUI iOS application

# Terminology
Property Wrapper: A property wrapper adds a layer of separation between code that manages how a property is stored and the code that defines a property
@Binding: The `@Binding` property wrapper enables a two-way connection between a property which stores data and a view that displays and mutates that data.

# The @Binding property wrapper
In Swift, `@Binding` is used for a two-way connection between a property and a view. When you need to pass a value type from a parent view to a child view (and wish the child view to mutate the value) the `@Binding` keyword is the answer to the problem.

*All this is better shown with an example (as usual).*

Before I go into detail I'll show the easiest example. We can hold a property and use the `@Binding` keyword to inform SwiftUI that when the property is changed by a view, the property itself should change too.

```swift
@Binding var text: String
```

If you were to use this text property it can be modified by a childView and changes would also reflect in the parent view that passed the property. When a view passes an `@Binding` property it does not store the value.

# The example
`@Binding` synchronises state between two views. Here `ContentView` is the parent and `NewView` is the child:

```swift
struct ContentView: View {
    @State var show = false

    var body: some View {
        NewView(show: $show)
    }
}

struct NewView: View {
    @Binding var show: Bool
    var body: some View {
        VStack {
            Button("Change show") {
                show = !show
            }
            Text(String(show))
        }
    }
}
```

In the parent view we have a declared `@State` property that defaults to false. When the button in the child view is pressed the state in the parent changes, causing a redraw and the `Text` to display the correct value.

# Notes to remember regarding @Binding

The `@Binding` does not own the data it uses, so it provides a reference to the data provided by another view (usually the parent). 
`@Binding` properties should not be accessed from a view's initializer. This is because the binding's value is not fully established until after the parent view's body property is evaluated. Accessing it prematurely can lead to unexpected behaviour or runtime errors. It's recommended to access these properties within the body of the view or other view methods to ensure they have been properly set.
`@Binding` is designed to work with value types (`struct`s and enums), not reference types (`class`es). When you change a value type, you're actually creating a new copy of the original. SwiftUI is able to track these changes and automatically update the UI.

# Conclusion
That isn't actually too tricky! Be sure not to access the properties within an initializer, and only use it when you wish to have a two-way flow between views. I'm sure you've got it from this article, it's not too tough!
Anyway, thanks for reading!
