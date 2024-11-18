import SwiftUI

final class OrderViewModel: ObservableObject {
    let order: Order
    
    init(order: Order) {
        self.order = order
    }
}
