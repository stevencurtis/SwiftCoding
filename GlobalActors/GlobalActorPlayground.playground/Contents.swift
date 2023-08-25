import UIKit

@globalActor
struct CustomGlobalActor {
  actor ActorType { }

  static let shared: ActorType = ActorType()
}

class MyClass {
    @MainActor
    var uiProperty: String = "Hello, UI!"

    @CustomGlobalActor
    var customProperty: String = "Hello, Custom!"

    @MainActor
    func updateUIProperty(value: String) {
        uiProperty = value
    }

    @CustomGlobalActor
    func updateCustomProperty(value: String) {
        customProperty = value
    }
}

let myClass = MyClass()
await print(myClass.customProperty)
