import Foundation
import XCTest

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

var cartManager: ShoppingCartProtocol = ShoppingCartManager()
let item1 = ShoppingCartItem(name: "Apple", price: 1.0)
let item2 = ShoppingCartItem(name: "Banana", price: 0.5)

cartManager.addItem(item1)
cartManager.addItem(item2)
cartManager.removeItem(item1)




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

//struct MockShoppingCartManager: ShoppingCartProtocol {
//    private class InternalState {
//        var items: [ShoppingCartItem] = []
//        var addItemCallCount: Int = 0
//        var removeItemCallCount: Int = 0
//    }
//    
//    private var state = InternalState()
//    
//    func addItem(_ item: ShoppingCartItem) {
//        state.addItemCallCount += 1
//        state.items.append(item)
//    }
//    
//    func removeItem(_ item: ShoppingCartItem) {
//        state.removeItemCallCount += 1
//        if let index = state.items.firstIndex(of: item) {
//            state.items.remove(at: index)
//        }
//    }
//    
//    var addItemCallCount: Int {
//        state.addItemCallCount
//    }
//    
//    var removeItemCallCount: Int {
//        state.removeItemCallCount
//    }
//    
//    var items: [ShoppingCartItem] {
//        state.items
//    }
//}

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

ShoppingCartManagerTests.defaultTestSuite.run()
