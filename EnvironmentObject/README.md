# Simplifying State Management in SwiftUI with @Environment: A Practical Guide
## Sharing State

In SwiftUI it's possible to share state and pass data across different views with `@Environment`.
Essentially you are making values globally accessible throughout the view hierarchy, creating a modular and maintainable codebase. 
To help you out I've created this article to demonstrate a practical example of `@Environment` that shows how you can use this property wrapper to enhance SwiftUI projects.

# What is it?
`@Environment` is a property wrapper that enables you to access values passed down from parent views or the app's environment.
To do so we can either use system-provided values or custom properties, although they both work in much the same way.

# System-provided environment values
SwiftUI comes built-in with some environment values that are useful in common scenarios. 
Here are some interesting ones I have picked to take a look at.

## Color scheme
We have an environment value that let's developers access the current color scheme, be it light or dark mode.
This means you can perhaps adjust the entire layout based on the mode set by the user. Nice!
The key part here is using `@Environment(\.colorScheme)` var colorScheme.
Note here I've also set two previews so I can compare them on the canvas.

```swift
import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack {
            Image(systemName: "heart.fill")
                .foregroundColor(colorScheme == .dark ? .pink : .black)
        }
    }
}

#Preview {
    ContentView()
        .environment(\.colorScheme, .dark)
}

#Preview {
    ContentView()
        .environment(\.colorScheme, .light)
}
```

## Size class
Size class helps in building responsive layouts, for example if you are unable to fit the same layout on compact or regular width devices.

```swift
struct SizeClassExampleView: View {
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        VStack {
            if sizeClass == .compact {
                Text("Compact Width")
                    .font(.body)
            } else {
                Text("Regular Width")
                    .font(.largeTitle)
            }
        }
    }
}

#Preview {
    SizeClassExampleView()
}
```

## Accessibility
There are a variety of different accessibility settings that a built-in using @Environment. Let's use just one, seeing if accessibility is enabled.

```swift
struct AccessibilityExampleView: View {
    @Environment(\.accessibilityEnabled) var accessibilityEnabled

    var body: some View {
        VStack {
            Text("Accessibility Features")
                .font(accessibilityEnabled ? .title : .body)
                .padding()
            
            if accessibilityEnabled {
                Text("Accessibility mode is enabled, showing larger text.")
            } else {
                Text("Standard text size.")
            }
        }
    }
}

#Preview {
    AccessibilityExampleView()
}
```

# Creating a Custom Environment Value
Creating a custom environment value isn't all that tough. Here is an example:

```swift
extension EnvironmentValues {
    @Entry var iconColor: Color = .red
}
```

This can then be accessed in a particular view using:

```swift
@Environment(\.iconColor) var iconColor
```

However what is interesting here is how the value is passed down.

Consider a `ContentView` parent, that contains `StarsView`. The parent view does not need to access the iconColor at all for it to be passed down to the child view.

Once again using multiple previews we can see this works: at the top level we assign the environment iconColor with `.environment(\.iconColor, .red)` in the first instance, and this is passed all the way through to StarsView without any interference on the way through.

```swift
struct StarsView: View {
    @Environment(\.iconColor) var iconColor

    var body: some View {
        Image(systemName: "star.fill")
            .foregroundStyle(iconColor)
            .font(.largeTitle)
    }
}

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack {
            Image(systemName: "heart.fill")
                .foregroundColor(colorScheme == .dark ? .pink : .black)
            HStack {
                StarsView()
                StarsView()
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(\.iconColor, .red)
        .environment(\.colorScheme, .dark)
    
}

#Preview {
    ContentView()
        .environment(\.iconColor, .blue)
        .environment(\.colorScheme, .light)
}
```
# Conclusion

That's quite fun, environment is a great property wrapper which opens up good state management practices in SwiftUI. Which is nice!

I certainly hope this article has helped you out!
