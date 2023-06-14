# The @Environment && @EnvironmentProperty SwiftUI Property Wrappers
## Update views with 'em

Although I've labeled this article as beginner, I've noticed that my previous article about [property wrappers](https://stevenpcurtis.medium.com/swiftuis-property-wrappers-a8771e8ef39b) just didn't make it seem so. So I think it really asks for a new article about the @Environment property wrapper.

Difficulty: **Beginner** | Easy | Normal | Challenging

# Prerequisites:
[Be able to produce a "Hello, World!" SwiftUI iOS application](https://medium.com/r/?url=https%3A%2F%2Fstevenpcurtis.medium.com%2Fhello-world-swiftui-92bcf48a62d3)

# Terminology
Property Wrapper: A property wrapper adds a layer of separation between code that manages how a property is stored and the code that defines a property
@Environment: a property wrapper that allows your views to access and react to system-wide settings and conditions
@EnvironmentObject: a property wrapper that allows your views to access and react to custom-defined settings and conditions

# The basic examples
**@Environment**
The classic example of a system-wide value is colorScheme, so the view can know if we are in dark or light model. A simple example can be the following

```swift
struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        Text("Hello, SwiftUI!")
            .foregroundColor(colorScheme == .dark ? .white : .black)
    }
}
```

In this case SwiftUI manages and provides the value  `colorScheme` and SwiftUI automatically updates views as needed. This means it does not need to be injected into the `App` `struct`, so effectively you can leave your App struct without making any modification (something like the following would suffice):

```swift
@main
struct MyApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

**@EnvironmentObject** 
This annotation is used to share custom data across the app. Because this does not exist in SwiftUI's environment (until you inject it at least!) you will need to manually inject it. We will therefore need a view to use the @EnvironmentObject and update the `App` `struct`. We can create a `UserSettings` class and for  the purposes of this article pass a `CGFloat` `fontSize` to our App.

```swift
final class UserSettings: ObservableObject {
    @Published var fontSize: CGFloat = 32.0
}
```

Which is then used in a view.

```swift
struct ContentView: View {
    @EnvironmentObject var settings: UserSettings

    var body: some View {
        Text("This is font size: \(settings.fontSize)")
            .font(.system(size: settings.fontSize))
    }
}
```

Which needs to be injected into the App:

```swift
@main
struct MyApp: App {
    var settings = UserSettings()

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(settings)
        }
    }
}
```

Which will ensure that the relevant `Text` is not only displayed with a 32 font size, but if that `fontSize` property needed to be updated the view would performantly update too.

# @Environment and @EnvironmentObject Under the Hood

In SwiftUI, `@Environment` allows views to reach into a storage space for system environment values, while @EnvironmentObject refers to custom-defined environment values.

Annotating a property with `@Environment` allows SwiftUI to provide a value from the current environment when the view is rendered. When the value changes, SwiftUI performantly re-renders the view with the updated environment value.

Annotating a property with `@EnvironmentObject` allows SwiftUI to provide a custom value from a class conforming to ObservableObject when the view is rendered, provided it is injected into the app. When the value changes, SwiftUI performantly re-renders the view with the updated environment value. You will be able to access this property from any view within the view hierarchy.

# Conclusion
These property wrappers are really important in coding SwiftUI. They provide ways to make views responsive to system settings and custom properties respectively. I hope that by understanding these property wrappers you can better create adaptable, user-friendly interfaces. Please do one thing though, remember that not every piece of data needs to be shared across an entire app so judgement should be employed where these property wrappers are used.
Anyway, thanks for reading!
