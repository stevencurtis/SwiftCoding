# Using Structs and Classes for Effective Management and Testing in Swift
## Make it a struct, please

As iOS developers we need to think about the best way to use data structures.

I want to explore a specific scenario where it makes sense to use a struct in an app, and matching classes in the test code.

# Terminology
class: A reference type, uses reference semantics and is allocated on the heap 
struct: A value type, uses value semantics and is allocated on the stack

# Comparing classes and structs
Structs are more performant than classes as they do not require heap allocation and deallocation (They are stored on the stack). For this reason alone it makes sense to default to structs if we have the choice between a class and a struct in our implementation.

However, there are further differences.

Structs are copied by value, whereas classes are copied by reference. Value semantics are clear and simple, and make structs easy to understand for developers. However classes support inheritance and reference semantics which may be required for certain use cases.

# An Example
Imagine we have an app where we want to manage a shopping cart.
By being good programmers we can define a protocol which outlines the methods, and means we can use dependency injection for testing.

## The Code

```swift
protocol ShoppingCartProtocol {
    func addItem(_ item: ShoppingCartItem)
    func removeItem(_ item: ShoppingCartItem)
}

struct ShoppingCartItem: Equatable {
    let name: String
    let price: Double
}

struct ShoppingCartManager: ShoppingCartProtocol {
    func addItem(_ item: ShoppingCartItem) {
        // calls a service to add an item
    }
    
    func removeItem(_ item: ShoppingCartItem) {
        // calls a service to remove an item
    }
}
```

A struct is used dues to it's simplicity, efficient memory management and value semantics.

## A Mock and Tests
We can use a mock with a shared internal state. This means we still adhere to the protocol and ensure that the state is updated correctly.

So here a class is used internally within the struct to handle mutable state. The result of this is an ability to use value semantics for the stuct while retaining the ability to track state changes within the internal class.

```swift
struct MockShoppingCartManager: ShoppingCartProtocol {
    private class InternalState {
        var items: [ShoppingCartItem] = []
        var addItemCallCount: Int = 0
        var removeItemCallCount: Int = 0
    }
    
    private var state = InternalState()
    
    func addItem(_ item: ShoppingCartItem) {
        state.addItemCallCount += 1
        state.items.append(item)
    }
    
    func removeItem(_ item: ShoppingCartItem) {
        state.removeItemCallCount += 1
        if let index = state.items.firstIndex(of: item) {
            state.items.remove(at: index)
        }
    }
    
    var addItemCallCount: Int {
        state.addItemCallCount
    }
    
    var removeItemCallCount: Int {
        state.removeItemCallCount
    }
    
    var items: [ShoppingCartItem] {
        state.items
    }
}

final class ShoppingCartManagerTests: XCTestCase {
    func testAddItem() {
        let mockCartManager = MockShoppingCartManager()
        let item = ShoppingCartItem(name: "Apple", price: 1.0)
        
        mockCartManager.addItem(item)
        
        XCTAssertEqual(mockCartManager.addItemCallCount, 1)
        XCTAssertEqual(mockCartManager.items, [item])
    }
    
    func testRemoveItem() {
        let mockCartManager = MockShoppingCartManager()
        let item = ShoppingCartItem(name: "Apple", price: 1.0)
        
        mockCartManager.addItem(item)
        mockCartManager.removeItem(item)
        
        XCTAssertEqual(mockCartManager.removeItemCallCount, 1)
        XCTAssertTrue(mockCartManager.items.isEmpty)
    }
}
```

The internal state is encapsulated within the struct, maintaining value semantics for the struct while providing reference semantics for state management. This avoids using mutating methods in the struct which would mean that the struct would not conform to the protocol.

## I'm Not Happy
Wrapping the class in the mock struct feels quite unwieldy.

Using an internal state class within a struct adds a layer of complexity to the code, and it's difficult to maintain this mock with this complexity and I think this is unnecessary.

A solution might be to use a class directly.

```swift
final class MockShoppingCartManager: ShoppingCartProtocol {
    private(set) var items: [ShoppingCartItem] = []
    private(set) var addItemCallCount: Int = 0
    private(set) var removeItemCallCount: Int = 0
        
    func addItem(_ item: ShoppingCartItem) {
        addItemCallCount += 1
        items.append(item)
    }
    
    func removeItem(_ item: ShoppingCartItem) {
        removeItemCallCount += 1
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }
}
```

Even though the production code uses a struct for performance (and to use value semantics) we can still use a class for our mock object to avoid unnecessary complexity while still helping us to produce robust testing.

The idea of this is to take a straightforward approach that is easy to understand and maintain and aligns to common testing practices in Swift.

Using reference semantics in a mock object means we can share the same instance of the mock object across tests, and verify state changes. Boilerplate code is limited and makes tests easier to write and understand, and potentially we can set up the mock object to simulate different behaviours or responses based on the state.

# Conclusion

The inspiration (such that it is) for this article is from my [network client](https://github.com/stevencurtis/NetworkClient) where I've created a struct for my error handler in the production code and used a class in the test code. 

Feel free to take a look at that, and think about how I've approached the problem and whether you think that it is appropriate for the challenge I faced.
