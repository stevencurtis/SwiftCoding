import SwiftUI

struct OrderView: View {
    let viewModel: OrderViewModel

    var body: some View {
        Text("Order Details: \(viewModel.order.description)")
    }
}
