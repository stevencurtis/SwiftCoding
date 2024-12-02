# Mastering SwiftUI's FocusState

When developing iOS apps using SwiftUI it is critical that focus is managed. That means we gain fine-grained control over which field is in focus at any given time, so long as we are using iOS 15 or later.
Here is an article about @FocusState, how is it can be used in any apps you might have brewing.

# What is @FocusState?
`@FocusState` is a property wrapper in SwiftUI that allows developers to manage focus programmatically for input fields like `TextField` and `SecureField`. By binding the focus state of these components to a shared `@FocusState` property, you gain fine-grained control over which field is in focus at any given time.

Essentially `FocusState` is an alternative to UIKit's `becomeFirstResponder` and gives similar functionality in a declarative world.

# An Example
```swift
struct ContentView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @FocusState private var focusedField: Field?
    
    enum Field: Hashable {
        case firstName
        case lastName
    }

    var body: some View {
        Form {
            TextField("First Name", text: $firstName)
                .focused($focusedField, equals: .firstName)
                .submitLabel(.next)
                .onSubmit {
                    withTransaction(Transaction(animation: nil)) {
                        focusedField = .lastName
                    }
                }
            
            TextField("Last Name", text: $lastName)
                .focused($focusedField, equals: .lastName)
                .submitLabel(.done)
                .onSubmit {
                    focusedField = nil
                }
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button("Previous") {
                    focusedField = .firstName
                }
                Button("Next") {
                    focusedField = .lastName
                }
            }
        }
    }
}
```

**The @FocusState Property Wrapper:**
We declare a `@FocusState` variable named `focusedField`. Its type is an optional Field `enum`, which defines the possible focusable fields in our form.

**The .focused() Modifier:**
Each `TextField` uses `.focused($focusedField, equals: .fieldCase)` to bind its focus state to the `focusedField` property.

**Submit Labels and Navigation:**
The `.submitLabel()` modifier allows us to specify the keyboard's return key action. Combined with `.onSubmit`, this facilitates seamless navigation between fields.

## The Problem - Solved with Transaction for Animation Suppression
In the implementation above when you move to the next field the keyboard moves down a bit before moving back up. That's not a good experience, and is a common issue when using SwiftUI forms.

This is because SwiftUI momentarily releases the focus when switching fields. 

The answer to this is to use [Transaction](https://medium.com/@stevenpcurtis/transactions-in-swiftui-c5d66ade8ab1) to suppress animations. 

The code for this is to essentially wrap assigning to `focusedField` in a `withTransaction` block.

```swift
withTransaction(Transaction(animation: nil)) {
  focusedField = .lastName
}
```

In situ this would look like the following:

```swift
struct ContentView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @FocusState private var focusedField: Field?
    
    enum Field: Hashable {
        case firstName
        case lastName
    }

    var body: some View {
        Form {
            TextField("First Name", text: $firstName)
                .focused($focusedField, equals: .firstName)
                .submitLabel(.next)
                .onSubmit {
                    withTransaction(Transaction(animation: nil)) {
                        focusedField = .lastName
                    }
                }
            
            TextField("Last Name", text: $lastName)
                .focused($focusedField, equals: .lastName)
                .submitLabel(.done)
                .onSubmit {
                    focusedField = nil
                }
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button("Previous") {
                    focusedField = .firstName
                }
                Button("Next") {
                    focusedField = .lastName
                }
            }
        }
    }
}
```

This works as as `withTransaction(Transaction(animation: nil))` suppresses animations, leaving the keyboard in place during transitions between fields.

# Conclusion
The `@FocusState` property wrapper is a powerful and flexible tool for managing focus in SwiftUI. It simplifies focus management, aligns seamlessly with SwiftUI's declarative paradigm, and enhances the overall user experience.

Good user experience == happy users. So that's nice.
