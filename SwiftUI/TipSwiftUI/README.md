# Create a SwiftUI Tip Calculator
## It's nice to be nice

# Before we start
Difficulty: Beginner | **Easy** | Normal | Challenging<br/>
This article has been developed using Xcode 12.4, and Swift 5.3.2

## The opportunity
Yes, yes. After Hello, World many many people create a tip calculator. SwiftUI is no different, and there are plenty of good reasons why we might make a nice little tip calculator. At least this particular article uses the current API (see tips below). SwiftUI seems to be built with MVVM and mind, and so it makes sense that this rather small project is based on that paradigm. 

## The tips
Refresh the preview window by using ⌘-⌥-P (command-Option-P)

Be mindful when you are looking for tutorials on the Internet - ObjectBinding and Bindable object (for example) have been deprecated since iOS13 (so they are not covered here).

# Creating the Project
We can create a new SwiftUI project, and here we are using the SwiftUI template to do so:
[Images/SwiftUIApp.png](Images/SwiftUIApp.png)

# Setting up the ViewModel and View
The `TipSwiftApp.swift` file

```swift
@main
struct TipSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            TipView(viewModel: TipViewModel())
        }
    }
}
```

The View will then have an initializer

```swift
import SwiftUI
import Combine
struct TipView: View {
    @ObservedObject var viewModel: TipViewModel
        init(viewModel: TipViewModel) {
            self.viewModel = viewModel
        }
...
```

Then the ViewModel will also have an initializer that we will use later

```swift
import Foundation
import SwiftUI
import Combine
class TipViewModel: ObservableObject {
    init() { }
}
```

# The CurrencyField
A currency field can be set up using the following code:

```swift
import SwiftUI

public struct CurrencyField: View {
    let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    
    let currencyEditingFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    let title: String
    let value: Binding<NSNumber?>
    @State private var valueWhileEditing: String = ""
    @State private var isEditing: Bool = false
    
    public init(_ title: String,
                value: Binding<NSNumber?>
    ) {
        self.title = title
        self.value = value
    }
    
    public var body: some View {
        TextField(
            title,
            text: Binding(
                get: {
                    self.isEditing ?
                        self.valueWhileEditing :
                        self.formattedValue
                }, set: { newValue in
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
    }
    
    private var formattedValue: String {
        guard let value = self.value.wrappedValue else { return "" }
        let formatter = isEditing ? currencyEditingFormatter : currencyFormatter
        guard let formattedValue = formatter.string(for: value) else { return "" }
        return formattedValue
    }
    
    private func updateValue(with string: String) {
        let newValue = currencyEditingFormatter.number(from: string)
        let newString = newValue.map { currencyEditingFormatter.string(for: $0) } as? String
        value.wrappedValue = newString.map { currencyEditingFormatter.number(from: $0) } as? NSNumber
    }
}
```

# The TipViewModel

```swift
import Foundation
import SwiftUI
import Combine

class TipViewModel: ObservableObject {
    // output
    @Published var tip: NSDecimalNumber?
    @Published var guestTip: NSDecimalNumber?
    @Published var toPay: NSDecimalNumber?
    
    // input
    @Published var amount: Decimal?
    @Published var guests = 2
    @Published var selectedTipIndex = 0
        
    let tipPercentages = [15, 20, 25]

    private var cancellable: Set<AnyCancellable> = []
    
    init() {
        $amount
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.calculateTip()
            })
            .store(in: &cancellable)
        
        $guests
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.calculateTip()
            })
            .store(in: &cancellable)

        $selectedTipIndex
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.calculateTip()
            })
            .store(in: &cancellable)
    }
    
    var tipPercentage: Int = 0
    let tipChoices = [10,15,20,25]
    
    func calculateTip() {
        guard let amount = amount else {
            return
        }
        
        let tipPercentage = (Double(tipPercentages[selectedTipIndex]) / 100) * NSDecimalNumber(decimal: amount).doubleValue / Double(guests)
        tip = NSDecimalNumber(value: tipPercentage)
        guestTip = NSDecimalNumber(value: tipPercentage / Double(guests))
        toPay = NSDecimalNumber(decimal: amount).adding(tip!)
    }
}

```

# Conclusion
If you plan, or might plan to use SwiftUI for future iterations of your application you can save yourself migration time in the future.

Alternatively you are taking a look at SwiftUI and using it to create your projects- fantastic!

Either way I hope this article has in some way helped you out, and I appreciate the time that you have spent reading this article.

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
