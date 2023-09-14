# The ViewBuilder Attribute in SwiftUI
## Compose complex views

Difficulty: Beginner | **Easy** | Normal | Challenging<br/>
This article has been developed using Xcode 14.2, and Swift 5.7.2

## Prerequisites:
You need to be able to code in Swift, perhaps using
[Playgrounds](https://medium.com/@stevenpcurtis.sc/coding-in-swift-playgrounds-1a5563efa089) and be able to use SwiftUI
You might need to know something about [result builders](https://medium.com/@stevenpcurtis/swifts-result-builders-abc0391f25b6) in order to happily follow this article

## Terminology
@resultBuilder: An attribute that transforms a sequence of statements into a single combined value
View: In SwiftUI a view is a protocol that defines a piece of user interface and is a building block for creating UI in SwiftUI
ViewBuilder: A SwiftUI attribute that enables the dynamic composition of views based on conditions without explicitly returning them

# Why?
## Simplified syntax
Put simply you want to use `@ViewBuilder` to create child views for a SwiftUI view without having to use return.

You will notice that something like this `View` avoids ugly use of return or commas in between the `Text` views:

```swift
struct MyView: View {
    var body: some View {
        VStack {
            Text("Hello")
            Text("World")
        }
    }
}
```
That is, without `@ViewBuilder` you'd need to wrap the views in a container view and use the `return` keyword with a comma between each item.

## Conditional views
`@ViewBuilder` constructs views from closures. With `@ViewBuilder` you can handle conditional views to display views based on conditions. Apple's [documentation](https://developer.apple.com/documentation/swiftui/viewbuilder#) has the following example:

```swift 
func contextMenu<MenuItems: View>(
    @ViewBuilder menuItems: () -> MenuItems
) -> some View
```

```swift
myView.contextMenu {
    Text("Cut")
    Text("Copy")
    Text("Paste")
    if isSymbol {
        Text("Jump to Definition")
    }
}
```

which is a nice use of SwiftUI DSL (Domain Specific Language). We can also extend this idea to build adaptive user interfaces using these language features.

## Add composition
Using `@ViewBuilder` helps you if you have broken down complex views into smaller parts and then choose to compose them to create more complex behavior.

Let us take an example. I can either compose a set of views using a `VStack` or similar (which actually uses `@ViewBuilder` under the hood) or by composing with a property or function annotated with `@ViewBuilder`.

The first option gives us a fine result. We can see it here:

```swift
VStack {
    ProfilePicture()
    UserName(name: user.name)
    UserBiography(bio: user.bio)
}
```

but we can use an `@ViewBuilder` to achieve the same

```swift
userProfileView(
    user: user
)
```

referencing the following function

```swift
@ViewBuilder
func userProfileView(user: User) -> some View {
    ProfilePicture()
    UserName(name: user.name)
    UserBiography(bio: user.bio)
}
```

Now there is a real issue with this code, that is the space between the subviews is controlled by SwiftUI and we have no possibility of fine-tuning it. *which isn't great*.

However it is good to know we are implicitly calling `buildEither(first:)` and `buildEither(second:)` methods under the hood in order to deal with this conditionality.  

# A great use
Now since `VStack` uses `@ViewBuilder` we can use the annotation in order to essentially produce a wrapper for the constituent views.

```swift

struct WrapperView<Content: View>: View {
    let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        VStack(alignment: .center) {
            content()
                .padding()
                .background(Color(.tertiarySystemBackground))
                .cornerRadius(16)
                .shadow(radius: 5)
        }
    }
}
```

which we can then use like 

```swift
WrapperView {
    Text("Hello, World")
}
```

or apply the formatting to various elements like we would for

```swift
WrapperView {
    Text("Hello, World")
    Text("Hello, World")
}
```

Essentially giving the same look and feel as setting up your own `VStack` style parent component.

# Conclusion

I hope this article has helped someone out, and perhaps I'll see you at the next article?
