# Create a CurrencyField in SwiftUI (Don't wrap!)
## There is no need to wrap a UIKit element

[Images/demo.gif](Images/demo.gif)

# Before we start
Difficulty: Beginner | Easy | **Normal** | Challenging<br/>
This article has been developed using Xcode 12.5, and Swift 5.4

## Keywords and Terminology:
TextField: A control in SwiftUI that displays an editable text interface

## Prerequisites:
* You need to be able to create a SwiftUI project, perhaps [in a Playground](https://stevenpcurtis.medium.com/use-swiftui-in-a-playground-4f8a74181593) if you are so inclined
* We will use [Property Getters and Setters in Swift](https://medium.com/swlh/property-getters-and-setters-in-swift-8157d5d027c7)

# The poor solution
Equivalent to a `UITextField` in `UIKit`, it feels like TextField is a little limited.

Many people will tell you to create a text field that only allows numbers with a decimal point (i.e. the number can be a fraction like 2.34) is to only allow the user to use the built-in decimalPad keyboard. 

Something like:

```swift
TextField("Amount", text: $stringAmount)
    .keyboardType(.decimalPad)
```

which would bind to an `@State` source of truth:

```swift
@State private var stringAmount: String = ""
```

*But* what if the user has a hardware keyboard attached? It turns out that the user can enter whatever they want. 

## The problem
Need I tell you that this is really, really bad. 

Not only can the user enter in data that would need some validation later in your application (which here `TextField` isn't helping us out with this) but the user should be able to enter in formatted data into the `TextField`. Awful.

# The Solution
One solution is wrapping a `UITextField` component for use in SwiftUI, but this isn't necessarily a great solution. If you can, you should go native.

In order to do so I've created a `CurrencyField.swift` file. The full code is below, but I'll run through some of the highlights here:

**The currencyFormatter**
The currency formatter will display the currency correctly according to the user's settings
```swift
let currencyFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    return formatter
}()
```

**The currencyEditingFormatter**
We have a formatter to format the input while the user is typing (which gives a good look and feel). This is different to the currencyFormatter above, since that one will fail (and potentially crash) for some user inputs.
```swift
let currencyEditingFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    return formatter
}()
```

**The Properties**
The title and value are set when initialized, and the `@State` properties represent data stored and managed by `SwiftUI`.
```swift
let title: String
let value: Binding<NSNumber?>

@State private var valueWhileEditing: String = ""
@State private var isEditing: Bool = false
```

**The Logic**
We use a `TextField`, and bind this to create a two-way binding between the `@State` properties defined above.

Get: If we are editing display the `valueWhileEditing`, if not display the `formattedValue`.
Set: We are only interested in numbers and decimal places, which we can use to make sure we remove any extra characters from the string before updating the value. If we only have a single decimal point, we set the edited value to the stripped value and update the formatted value. If not, we might have more than one decimal place or any number of extra values, which can be removed by comparing the stripped values with the existing value length and remove the unnecessary Characters and set the valueWhileEditing and update the value. 

When we have finished editing, we set the `@State` and update the value to present to the user.

```swift
TextField(
    title,
    text: Binding(
        get: {
            self.isEditing ?
                self.valueWhileEditing :
                self.formattedValue
        },
        set: { newValue in
            let strippedValue = newValue.filter{ "0123456789.".contains($0) }
            if strippedValue.filter({$0 == "."}).count <= 1 {
                self.valueWhileEditing = strippedValue
                self.updateValue(with: strippedValue)
            } else {
                let newValue = String(
                    strippedValue.dropLast(strippedValue.count - self.valueWhileEditing.count)
                )
                self.valueWhileEditing = newValue
                self.updateValue(with: newValue)
            }
        }
    ), onEditingChanged: { isEditing in
        self.isEditing = isEditing
        self.valueWhileEditing = self.formattedValue
    }
)
```

## The Callsite

We are going to bind a getter and setter property . This is very useful since we can *store* the output `NSDecimalNumber` from the component - awesome!

```swift
CurrencyField(
    "Enter meal cost",
    value: Binding(get: {
        amount.map { NSDecimalNumber(decimal: $0) }
    }, set: { number in
        amount = number?.decimalValue
    })
)
```

# The Complete Solution Code
This is also available in the Repo. 

## CurrencyField.swift
```swift
import SwiftUI

public struct CurrencyField: View {
    
    // The NumberFormatter that will display the currency correctly
    // for the user's settings
    let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    
    // The NumberFormatter used while editing. This prevents crashes
    // from a more stringent "end" formatter
    let currencyEditingFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    // Constant properties not managed by SwiftUI
    let title: String
    let value: Binding<NSNumber?>
    
    // @State represents data stored and managed by SwiftUI
    @State private var valueWhileEditing: String = ""
    @State private var isEditing: Bool = false
    
    
    /// Public initializer
    /// - Parameters:
    ///   - title: The title of the component
    ///   - value: The desired value of the component
    public init(_ title: String,
                value: Binding<NSNumber?>
    ) {
        self.title = title
        self.value = value
    }
    
    public var body: some View {
        // Use a TextField
        TextField(
            title,
            // text is a two way binding with the @State data
            text: Binding(
                get: {
                    // if we are editing, return the editing value, if not return the final
                    // formatted version
                    self.isEditing ?
                        self.valueWhileEditing :
                        self.formattedValue
                },
                // set the new value
                set: { newValue in
                    // we are only interested in numbers and the decimal
                    let strippedValue = newValue.filter{ "0123456789.".contains($0) }
                    // if there is less than one decimal point
                    if strippedValue.filter({$0 == "."}).count <= 1 {
                        // update the editing value
                        self.valueWhileEditing = strippedValue
                        // update the current value
                        self.updateValue(with: strippedValue)
                    } else {
                        // we might have more than one decimal place
                        let newValue = String(
                            // remove all of the extra decimal places and/or other characters
                            strippedValue.dropLast(strippedValue.count - self.valueWhileEditing.count)
                        )
                        // update the editing value
                        self.valueWhileEditing = newValue
                        // update the current value
                        self.updateValue(with: newValue)
                    }
                }
            ), onEditingChanged: { isEditing in
                // once the editing is finished
                // set the isEditing Boolean
                self.isEditing = isEditing
                // set the editing value to be the end value
                self.valueWhileEditing = self.formattedValue
            }
        )
    }
    
    // a private property which is represents the current formatted value as a string
    private var formattedValue: String {
        // if there isn't an underlying value, the formatted value is nothing
        guard let value = self.value.wrappedValue else { return "" }
        // if we are editing using the editing formatter, else use the currency formatter
        let formatter = isEditing ? currencyEditingFormatter : currencyFormatter
        // if we can't format the String, no String should be returned
        guard let formattedValue = formatter.string(for: value) else { return "" }
        // return the formatted value
        return formattedValue
    }
    
    private func updateValue(with string: String) {
        // format the string value as NSNumber?, using the formatter
        let newValue = currencyEditingFormatter.number(from: string)
        // convert that NSNumber? to a String
        let newString = newValue.map { currencyEditingFormatter.string(for: $0) } as? String
        // convert the string to an NSNumber, and assign to the underlying value property
        value.wrappedValue = newString.map { currencyEditingFormatter.number(from: $0) } as? NSNumber
    }
}
```

## ContentView.swift

```swift
import SwiftUI

struct ContentView: View {
    @State private var stringAmount: String = ""
    @State private var amount: Decimal?
    
    var body: some View {
        TextField("Amount", text: $stringAmount)
            .keyboardType(.decimalPad)
        
        CurrencyField(
            "Enter meal cost",
            value: Binding(get: {
                amount.map { NSDecimalNumber(decimal: $0) }
            }, set: { number in
                amount = number?.decimalValue
            })
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```

# Conclusion
That's it! 

We can use SwiftUI components to create rather splendid experiences for users. This is just one example - and if you want a full example using this...well, I feel another article coming on...!

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
