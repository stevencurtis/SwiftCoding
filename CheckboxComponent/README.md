# Crafting SwiftUI Custom Checkboxes for User Agreements
## This can work

This article uses code from my simple design library system. Take a look at [https://github.com/stevencurtis/DesignLibrary/tree/main](https://github.com/stevencurtis/DesignLibrary/tree/main) to see how that works.

Difficulty: Beginner | Easy | **Normal** | Challenging<br/>
This article has been developed using Xcode 15.0, and Swift 5.9

## Terminology:
SwiftUI: A modern way to declare user interfaces for any Apple device in Swift.
Binding: A SwiftUI property wrapper that connects a property to a source of truth, allowing for interactive updates.
ObservableObject: A type of object with a publisher that emits before the object has changed, used in SwiftUI to manage model data.

# Background
In many applications, especially those involving legal agreements, it's common to present users with terms and conditions that they must agree to before proceeding. Typically, this involves checkboxes that users must tap to indicate acceptance. Traditionally, this could become cumbersome with UIKit, but SwiftUI simplifies this process significantly, enhancing both developer and user experience.

Creating a reusable and visually appealing checkbox component in SwiftUI not only streamlines code but also aligns with modern UI practices. Here's how to enhance your SwiftUI views with custom checkboxes.

There are two versions of this code, one that uses the new observable macro and one that uses `ObservableObject`. To maximise how easy this is to read I'll cover the `ObservableObject` version first and then copy-paste the observable macro version below it. I hope this helps everyone out!

# Implementation
## Implement the checkbox view
Here I start with the `CheckboxView` component in SwiftUI. This view manages the image and allows the user to click it and the component reacts as expected.

```swift
struct CheckboxView: View {
    @Binding var isChecked: Bool
    let label: String

    var body: some View {
        HStack {
            Text(label)
            Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                .onTapGesture {
                    isChecked.toggle()
                }
        }
    }
}
```

## Linking TermsViewModel

```swift
final class TermsViewModel: ObservableObject {
    @Published var termsConditions: [TermsCondition] = []
    @Published var buttonState: ButtonState = .disabled
}
```

## Binding the view to the view model
Construct the TermsView, which employs CheckboxView for user interaction, binding it to the view model:

```swift
struct TermsView: View {
    @ObservedObject private var viewModel: TermsViewModel

    init(viewModel: TermsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("Please carefully read and agree to the Terms and Conditions before proceeding")
            Divider()
            
            ForEach($viewModel.termsConditions) { $term in
                CheckboxView(isChecked: $term.isChecked, label: term.label)
            }
            Spacer()
            StatefulButtonView(buttonState: $viewModel.buttonState)
        }
        .padding()
    }
    
    struct CheckboxView: View {
        @Binding var isChecked: Bool
        let label: String
        var body: some View {
            HStack(alignment: .center) {
                Text(label)
                Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                    .onTapGesture {
                        isChecked.toggle()
                        print("Checkbox tapped, new state: \(isChecked)") 
                    }
            }
        }
    }
}
```

# The Code
## TermsView
```swift
import SwiftUI

struct TermsView: View {
    @ObservedObject private var viewModel: TermsViewModel

    init(viewModel: TermsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("Please carefully read and agree to the Terms and Conditions before proceeding")
            Divider()
            
            ForEach($viewModel.termsConditions) { $term in
                CheckboxView(isChecked: $term.isChecked, label: term.label)
            }
            Spacer()
            StatefulButtonView(buttonState: $viewModel.buttonState)
        }
        .padding()
    }
    
    struct CheckboxView: View {
        @Binding var isChecked: Bool
        let label: String
        var body: some View {
            HStack(alignment: .center) {
                Text(label)
                Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                    .onTapGesture {
                        isChecked.toggle()
                        print("Checkbox tapped, new state: \(isChecked)") 
                    }
            }
        }
    }
}

#Preview {
    TermsView(viewModel: TermsViewModel())
}
```

## TermsViewModel
```swift
import Combine
import SwiftUI

final class TermsViewModel: ObservableObject {
    @Published var termsConditions: [TermsConditions] = [
        TermsConditions(label: "Terms One", isChecked: false),
        TermsConditions(label: "Terms Two", isChecked: false),
    ] {
        didSet {
            buttonState = termsConditions.allSatisfy({ $0.isChecked }) ? .enabled : .disabled
        }
    }
    @Published var buttonState: ButtonState = .disabled
    private var cancellables: Set<AnyCancellable> = []
}


struct TermsConditions: Identifiable {
    var id = UUID()
    
    let label: String
    var isChecked: Bool
}
```

# The ObservableMacro version
So you want to use the @Observable macro? No problem, that's cool and we can do that for you.
## TermsView
```swift
import SwiftUI

struct TermsView: View {
    private var viewModel: TermsViewModel

    init(viewModel: TermsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        @Bindable(wrappedValue: viewModel) var viewModel: TermsViewModel
        VStack(alignment: .leading) {
            Text("Please carefully read and agree to the Terms and Conditions before proceeding")
            Divider()
            ForEach($viewModel.termsConditions) { $term in
                CheckboxView(isChecked: $term.isChecked, label: term.label)
            }
            Spacer()
            StatefulButtonView(buttonState: $viewModel.buttonState)
        }
        .padding()
    }
    
    struct CheckboxView: View {
        @Binding var isChecked: Bool
        let label: String
        var body: some View {
            HStack(alignment: .center) {
                Text(label)
                Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                    .onTapGesture {
                        isChecked.toggle()
                        print("Checkbox tapped, new state: \(isChecked)") 
                    }
            }
        }
    }
}

#Preview {
    TermsView(viewModel: TermsViewModel())
}
```
## TermsViewModel
```swift
import Combine
import Observation
import SwiftUI

@Observable
final class TermsViewModel {
    var termsConditions: [TermsConditions] = [
        TermsConditions(label: "Terms One", isChecked: false),
        TermsConditions(label: "Terms Two", isChecked: false),
    ] {
        didSet {
            buttonState = termsConditions.allSatisfy({ $0.isChecked }) ? .enabled : .disabled
        }
    }
    var buttonState: ButtonState = .disabled
    private var cancellables: Set<AnyCancellable> = []
}


struct TermsConditions: Identifiable {
    var id = UUID()
    
    let label: String
    var isChecked: Bool
}
```

# Conclusion

Creating custom checkboxes in SwiftUI not only makes your code more reusable and maintainable but also provides a better user experience by aligning with modern design trends. By following this guide, you can implement interactive and visually consistent checkboxes in your SwiftUI applications, improving your app's onboarding process and legal compliance.

Thanks for reading!

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 

