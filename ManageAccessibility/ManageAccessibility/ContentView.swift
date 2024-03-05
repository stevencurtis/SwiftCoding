import SwiftUI

struct ContentView: View {
    @State private var accessibilityLabel = "Initial label"
    
    var body: some View {
        VStack {
Text("A standard Text component")
    .accessibilityLabel(Text("This is standard accessibility"))
            ExternalAccessibleView()
InitializerAccessibleView(label: "Custom Message", hint: "Shows a message with custom accessibility settings")
Text("Adjustable Text")
    .accessibilitySettings(label: "Adjustable", hint: "This text can be adjusted")
MyText(text: "My Text")
    .accessibilityLabel(Text("this is my text"))
            AccessibleDynamicView(dynamicLabel: $accessibilityLabel)
            Button("Change Label") {
                accessibilityLabel = "Updated label"
            }
        }
        .padding()
    }
}

struct ExternalAccessibleView: View {
    var body: some View {
        Text("Hello, World!")
            .accessibilityLabel("Greeting")
            .accessibilityHint("Displays a welcoming message")
    }
}

struct InitializerAccessibleView: View {
    var label: String
    var hint: String

    init(label: String, hint: String) {
        self.label = label
        self.hint = hint
    }

    var body: some View {
        Text("Example Text")
            .accessibilityLabel(label)
            .accessibilityHint(hint)
    }
}

struct AccessibilityModifier: ViewModifier {
    var label: String
    var hint: String

    func body(content: Content) -> some View {
        content
            .accessibilityLabel(label)
            .accessibilityHint(hint)
    }
}

extension View {
    func accessibilitySettings(label: String, hint: String) -> some View {
        self.modifier(AccessibilityModifier(label: label, hint: hint))
    }
}

struct MyText: View {
    var text: String
    private var accessibilityLabel: Text?
    
    init(text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .accessibilityLabel(accessibilityLabel ?? Text(text))
    }
    
    func accessibilityLabel(_ label: Text) -> some View {
        var copy = self
        copy.accessibilityLabel = label
        return copy
    }
}

struct AccessibleDynamicView: View {
    @Binding var dynamicLabel: String

    var body: some View {
        Text("Dynamic content here")
            .accessibilityLabel(dynamicLabel)
    }
}

#Preview {
    ContentView()
}
