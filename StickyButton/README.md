# A Sticky Button in SwiftUI
## A simple example

Sticky buttons are a popular UI pattern where a button remains fixed at the bottom of the screen, regardless of scrolling or keyboard interactions. They are widely used in apps for actions like submitting a form, sending a message, or navigating to the next screen.

This article demonstrates how to create a sticky button in SwiftUI, leveraging its declarative syntax and modern state management tools. We’ll use FocusState, introduced in iOS 15, to manage keyboard interactions seamlessly.

Difficulty: **Beginner** | Easy | Normal | Challenging<br/>
This article has been developed using Xcode 15.0, and Swift 5.9

## Terminology:
SwiftUI: A simple way to build user interfaces Across Apple platforms

# In the past...
I remember when we would need to know the height of the keyboard and move our views appropriately.

If you're not using UIKit you are no longer using the paradigms that matched SwiftUI.

So let us go full SwiftUI!

# Why Use SwiftUI for Sticky Buttons
SwiftUI simplifies sticky button implementation by eliminating boilerplate code. Features like declarative layouts and state-driven updates make it easy to:
•    Create responsive layouts that adapt to keyboard and content changes.
•    Bind focus states for smooth user interactions.
•    Style and customize buttons with minimal effort.

Compared to UIKit, where managing keyboard height or scroll view insets was necessary, SwiftUI provides a more intuitive and less error-prone approach.

# The SwiftUI solution
Since iOS15 you are able to use FocusState to maintain a binding to a `TextField` about whether it is focussed or not.

Here’s how to build a layout with a sticky button:

```swift
import SwiftUI

struct ContentView: View {
    @State private var text: String = ""
    @FocusState private var isTextFieldFocused: Bool
    var body: some View {
        VStack {
            ScrollView {
                TextField("Type something...", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                ForEach(0..<10) { _ in
                    Text("This is text content")
                        .padding()
                }
            }
            Spacer()
            Button(action: {
                isTextFieldFocused = false
            }) {
                Text("Sticky Button")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}
```
## Focus Management with FocusState
The `FocusState` property wrapper binds the focus state of a `TextField` to a Boolean property. This allows us to programmatically control when the field gains or loses focus.
## Button Styling
The button is styled using frame, padding, background, and cornerRadius.
It spans the width of the screen with `frame(maxWidth: .infinity)`.
## Keyboard Interaction
By observing `isTextFieldFocused`, we adjust the bottom padding to ensure the button doesn't overlap with the keyboard.

# Common Pitfalls and Solutions
## Button Overlaps with Keyboard
Ensure bottom padding adjusts dynamically using `isTextFieldFocused`.
## Button Doesn't Respond
Check if `isTextFieldFocused` is correctly bound to the `TextField`.
## Layout Breaks on Rotation
Use `.safeAreaInset()` to ensure consistent layout across orientations.

# Conclusion 
SwiftUI’s declarative nature makes implementing UI patterns like sticky buttons a breeze. By leveraging features like `FocusState` and SwiftUI’s responsive layout tools, you can create polished, accessible, and modern interfaces with minimal effort.

Whether you’re building a form, a messaging app, or an e-commerce platform, sticky buttons are a powerful tool to improve usability. Experiment with the provided examples, and don’t hesitate to innovate!
