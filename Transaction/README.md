# Transactions in SwiftUI

View updates and animations in SwiftUI can be managed through transactions. 

This article runs through transactions, what they are and why you might want to use them.

# What are transactions
(Transaction)[https://developer.apple.com/documentation/swiftui/transaction] can be used to pass animation between views in a view hierarchy.

That pretty much means that they are used to manage and customise the behaviour of animations, providing a way to override animation-related properties during state updates.

# Key Features of Transactions
Transactions give granular control over animations within a view hierarchy.

They allow you to modify default animations or customise specific animation properties.

# Use of Transactions
## Dynamic Animation Based on Scale
Here is an example where an image scales up when tapped. The animation type changes dynamically depending on the current applied scale, and if it exceeds 1.5 a spring animation is used, unless an ease-in-out animation is used.

```swift
struct ContentView: View {
    @State private var scale: CGFloat = 1.0

    var body: some View {
        VStack {
            AnimatedView(scale: scale)
                .transaction { transaction in
                    if scale > 1.5 {
                        transaction.animation = .spring(response: 0.5, dampingFraction: 0.5)
                    } else {
                        transaction.animation = .easeInOut(duration: 2)
                    }
                }
                .onTapGesture {
                    scale += 0.1
                }
        }
    }
}

private struct AnimatedView: View {
    var scale: CGFloat
    
    var body: some View {
        Image(.rosa)
            .resizable()
            .scaledToFit()
            .frame(width: 100 * scale, height: 100 * scale)
    }
}
```

**The Modifier**
The .transaction modifier is applied to the struct AnimatedView. Inside the modifier, the transaction.animation property is dynamically set based on the scale value.
If scale > 1.5, a spring animation is used, creating a bouncy effect.
Otherwise, an ease-in-out animation smoothens the transition.

**State Change**
Tapping the VStack increments the scale, which triggers a re-render of the view hierarchy. The transaction dynamically adjusts the animation type based on the updated scale.

## Overriding
Here a custom animation can override an implicit one.
I've made the implicit animation slow to make it clear it's running.

```swift
import SwiftUI

struct ContentView: View {
    @State private var scale: CGFloat = 1.0

    var body: some View {
        VStack {
            AnimatedView(scale: scale)
                .onTapGesture {
                    var transaction = Transaction(animation: .linear)
                    transaction.disablesAnimations = true
                    withTransaction(transaction) {
                        scale += 0.1
                    }
                }
        }
    }
}

private struct AnimatedView: View {
    var scale: CGFloat
    
    var body: some View {
        Image(.rosa)
            .resizable()
            .scaledToFit()
            .frame(width: 100 * scale, height: 100 * scale)
            .animation(.bouncy(duration: 5.0), value: scale)
    }
}

#Preview {
    ContentView()
}
```
The gold here is `transaction.disablesAnimations = true` that disables the overridden animation.

# Conclusion
The transaction modifier is a versatile tool in SwiftUI that gives you fine-grained control over animations. By dynamically adjusting animations, you can enhance user experience and create context-sensitive transitions. Whether you're customising animations or disabling them entirely, transactions offer a level of control that goes beyond the basics of `.animation`.

Use transactions when you need:
• Dynamic animation behaviour.
• Selective animation disabling.
• Fine-tuned control over how state changes are animated.
I hope this article has helped you out.
