# WWDC 2023: Discover Observation in SwiftUI
## Observation Design Pattern? Maybe

For the purposes of using the WWDC video I wanted complete code. This article provides that, but is not intended to be a replacement for the code in https://developer.apple.com/videos/play/wwdc2023/10149/?time=473 and I recommend you watch that video. This Medium article requires Xcode 15 to be running.

# What is observation?
Observation has been added to Swift for tracking changes to properties, and uses macros to do so. Adding @Observable allows us to make the UI respond to data models.

The simple example:

```swift
@Observable class FoodTruckModel {    
    var orders: [Order] = []
    var donuts = Donut.all
}
```

We have code here which means that the properties orders and donuts are effectively @Published types.

# The example
There is a food truck example in the video. Unfortunately on it's own it cannot run.
They call this a simple example. When the body is executed SwiftUI knows it access donuts, so if the property is changed the system knows to re-render the view.

```swift
@Observable class FoodTruckModel {    
  var orders: [Order] = []
  var donuts = Donut.all
}

struct DonutMenu: View {
  let model: FoodTruckModel
    
  var body: some View {
    List {
      Section("Donuts") {
        ForEach(model.donuts) { donut in
          Text(donut.name)
        }
        Button("Add new donut") {
          model.addDonut()
        }
      }
    }
  }
}
```

To make a nice example similar to the project code I needed to add an order struct, donut (conforming to Identifiable) and add previews.

```swift
import SwiftData
import SwiftUI

struct Order {
    let orderNo: String
}

struct Donut: Identifiable {
    var id: UUID = UUID()
    var name: String
    var price: Double

    static let donuts = [
        Donut(name: "Glazed", price: 1.0),
        Donut(name: "Chocolate", price: 1.5),
        Donut(name: "Sprinkles", price: 1.2)
    ]
    
    static var all: [Donut] {
        return donuts
    }
}

@Observable class FoodTruckModel {
  var orders: [Order] = []
  var donuts = Donut.all
}

extension FoodTruckModel {
    func addDonut() {
        donuts.append(Donut(name: "Donut", price: 0.5))
    }
}

struct DonutMenu: View {
  let model: FoodTruckModel
    
  var body: some View {
    List {
      Section("Donuts") {
        ForEach(model.donuts) { donut in
          Text(donut.name)
        }
        Button("Add new donut") {
          model.addDonut()
        }
      }
    }
  }
}

#Preview {
    DonutMenu(model: .init())
}
```

In my examples the previews also allow you to add that extra donut!
Apple seem to be recommending @Observable as suitable for new development. I guess why wouldn't we use it?
They've then created an updated model with order count

```swift
@Observable class FoodTruckModel {    
  var orders: [Order] = []
  var donuts = Donut.all   var orderCount: Int { orders.count }
}

struct DonutMenu: View {
  let model: FoodTruckModel
    
  var body: some View {
    List {
      Section("Donuts") {
        ForEach(model.donuts) { donut in
          Text(donut.name)
        }
        Button("Add new donut") {
          model.addDonut()
        }
      }
      Section("Orders") {
        LabeledContent("Count", value: "\(model.orderCount)")
      }
    }
  }
}
```

Which I've got running with:

```swift
import SwiftData
import SwiftUI

import SwiftData
import SwiftUI

struct Order {
    let orderNo: String
}

struct Donut: Identifiable {
    var id: UUID = UUID()
    var name: String
    var price: Double

    static let donuts = [
        Donut(name: "Glazed", price: 1.0),
        Donut(name: "Chocolate", price: 1.5),
        Donut(name: "Sprinkles", price: 1.2)
    ]
    
    static var all: [Donut] {
        return donuts
    }
}

@Observable class FoodTruckModel {
  var orders: [Order] = []
  var donuts = Donut.all
  var orderCount: Int { orders.count }
}

extension FoodTruckModel {
    func addDonut() {
        donuts.append(Donut(name: "Donut", price: 0.5))
    }
}

struct DonutMenu: View {
  let model: FoodTruckModel
    
  var body: some View {
    List {
      Section("Donuts") {
        ForEach(model.donuts) { donut in
          Text(donut.name)
        }
        Button("Add new donut") {
          model.addDonut()
        }
      }
        Section("Orders") {
            LabeledContent("Count", value: "\(model.orderCount)")
        }
    }
  }
}

#Preview {
    DonutMenu(model: .init())
}
```

Now if the orders change the label will be updated. SwiftUI tracks when properties change so only those views that require updates actually update when the relevant property is updated.

# Property Wrappers

In the case above you don't need [property wrappers](https://medium.com/r/?url=https%3A%2F%2Fgithub.com%2Fstevencurtis%2FSwiftCoding%2Ftree%2Fmaster%2FSwiftUI%2FPropertyWrappers%2F). You'll need to use property wrappers for some code.

## @State
The `@State` property wrapper is a SwiftUI-specific feature that allows for mutable state to be stored inside a SwiftUI view, which is normally a struct and thus immutable. This state is preserved across view updates, and changes to the state can trigger an update to the view's body. So `@State` provides a mechanism for a view to have it's own state stored in a model. 

In the example we have some code that adds a donut to a list

```swift
struct DonutListView: View {
    var donutList: DonutList
    @State private var donutToAdd: Donut?

    var body: some View {
        List(donutList.donuts) { DonutView(donut: $0) }
        Button("Add Donut") { donutToAdd = Donut() }
            .sheet(item: $donutToAdd) {
                TextField("Name", text: $donutToAdd.name)
                Button("Save") {
                    donutList.donuts.append(donutToAdd)
                    donutToAdd = nil
                }
                Button("Cancel") { donutToAdd = nil }
            }
    }
}
```

Which is great. It won't compile since in the example code the TextField expects a `Binding<String>`, but `$donutToAdd.name` provides a `Binding<String>?` because donutToAdd is an optional. `Binding<Donut?>` can't simply be force-unwrapped either.

Since `donutToAdd` is optional, there is a temptation to force-unwrap it. This isn't good as it is dangerous code, so a better alternative is to use optional binding. I'll add in the `DonutList` class and `DonutView` to create a simple list with this data.

```swift
import SwiftUI

struct DonutListView: View {
    var donutList: DonutList
    @State private var donutToAdd: Donut?
    
    var donutName: Binding<String> {
        Binding<String>(
            get: { self.donutToAdd?.name ?? "" },
            set: { self.donutToAdd?.name = $0 }
        )
    }
    
    var body: some View {
        List(donutList.donuts) { DonutView(donut: $0) }
        Button("Add Donut") { donutToAdd = Donut() }
            .sheet(item: $donutToAdd) {_ in
                TextField("Name", text: donutName)
                Button("Save") {
                    if let donut = donutToAdd {
                        donutList.donuts.append(donut)
                    }
                    donutToAdd = nil
                }
                Button("Cancel") { donutToAdd = nil }
            }
    }
}

final class DonutList {
    var donuts: [Donut]
    init(donuts: [Donut]) {
        self.donuts = donuts
    }
}

struct DonutView: View {
    var donut: Donut
    
    var body: some View {
        Text(donut.name)
    }
}
```

## @Environment
The `@Environment` property wrapper is used to access value provided by ancestors a view in the view hierarchy. This means that values can be propagated as globally accessible values. These are stored in SwiftUI's `Environment` which is a collection of both system and custom-defined values passed down the view hierarchy.

The `@Environment` property wrapper in SwiftUI is used to access values provided by the ancestors of a view in the view hierarchy. These values are stored in SwiftUI's `Environment`, which is a collection of system-provided and custom-defined values that can be automatically passed down the view hierarchy, and is commonly used for things like `@Environment(\.colorScheme)` var colorScheme for accessing the current colour scheme.

For example, SwiftUI provides some environment values like `@Environment(\.managedObjectContext)` var context for Core Data, or `@Environment(\.colorScheme) var colorScheme` for accessing the current colour scheme (dark or light mode).
In this video Apple give us a code snippet:

```swift
@Observable class Account {
  var userName: String?
}

struct FoodTruckMenuView : View {
  @Environment(Account.self) var account

  var body: some View {
    if let name = account.userName {
      HStack { Text(name); Button("Log out") { account.logOut() } }
    } else {
      Button("Login") { account.showLogin() }
    }
  }
}
```

Unfortunately this code will not compile, since Account does not have a `logOut` or `showLogin` function.
This is easily fixed:

```swift
import SwiftData
import SwiftUI

@Observable class Account {
  var userName: String? = ""
  var logOut: (() -> ()) = { print("logOut") }
  var showLogin: (() -> ()) = { print("showLogin") }
}

struct FoodTruckMenuView : View {
  @Environment(Account.self) var account

  var body: some View {
    if let name = account.userName {
        HStack { Text(name); Button("Log out") { (account.logOut)() } }
    } else {
      Button("Login") { account.showLogin() }
    }
  }
}
```

Simply printing *logOut* and *showLogin* to the console are not ideal, but it gets this code to compile. When the userName changes the view would update, meaning this would be a great use of both observation and `@environment`.

## @Bindable
The `@Binding` property wrapper provides a way to create a two-way binding between a view and a piece of data that is owned by another view or view controller. So we create a connection between a property which stores data and a view which uses it. `@Binding` creates a mutable property which when changed also changes the source of truth.

This means that a child view can modify a value owned by a parent view, creating a two-way communication where the child view can mutate data and the changes are reflected in the parent view.

This given code compiles fine, which is nice! In this example we would want to be able to edit the donut name from the `TextField`, and the following code would allow you to do exactly that, and contains the standard `$` syntax to indicate the binding.

```swift
@Observable class Donut {
  var name: String
}

struct DonutView: View {
  @Bindable var donut: Donut

  var body: some View {
    TextField("Name", text: $donut.name)
  }
}
```

# Storing @Observable types in an Array
Each model stored in the following donuts array is @observable. Unfortunately the following code does not have the randomName() function, but this is easily fixed.

```swift
@Observable class Donut {
  var name: String
}

struct DonutList: View {
  var donuts: [Donut]
  var body: some View {
    List(donuts) { donut in
      HStack {
        Text(donut.name)
        Spacer()
        Button("Randomize") {
          donut.name = randomName()
        }
      }
    }
  }
}
```

When the name of any donut is changed, the view updates accordingly. So that means when the randomize button is pressed on a particular donut, the data will change.
Let us take a look at the updated code:

```swift
import SwiftData
import SwiftUI

@Observable class Donut: Identifiable {
  var name: String = ""
}

struct DonutList: View {
  var donuts: [Donut]
  var body: some View {
    List(donuts) { donut in
      HStack {
        Text(donut.name)
        Spacer()
        Button("Randomize") {
          donut.name = randomName()
        }
      }
    }
  }
}

private func randomName() -> String {
    let length = Int.random(in: 1..<10)
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length).map{ _ in letters.randomElement()! })
}
```

# Manual Observation
Non-observable locations may be read if we tell `@Observable` can be read and the name stored. This applies if a computed property does not have any stored property it is comprised with. Here is the code:

```swift
@Observable class Donut {
  var name: String {
    get {
      access(keyPath: \.name)
      return someNonObservableLocation.name 
    }
    set {
      withMutation(keyPath: \.name) {
        someNonObservableLocation.name = newValue
      }
    }
  } 
}
```

Unfortunately `someNonObservableLocation` is not defined, so I can do that here:

```swift
import SwiftData

@Observable class Donut {
  private var someNonObservableLocation = DataStorage()
  var name: String {
    get {
      access(keyPath: \.name)
      return someNonObservableLocation.name
    }
    set {
      withMutation(keyPath: \.name) {
        someNonObservableLocation.name = newValue
      }
    }
  }
}

class DataStorage {
    var name: String = ""
}
```

Which then compiles and works as expected.

#Conclusion
Observation is something people are getting excited about in the Swift community, and no wonder. I hope I get the chance to use it soon, as it seems a particularly cool addition to Swift.
Anyway, thanks for reading!
