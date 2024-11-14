import SwiftUI

struct ContentView: View {
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Button("Go to User Profile") {
                    let user = User(id: 1, name: "Ahmed")
                    path.append(user)
                }
                Button("Go to Order Details") {
                    let order = Order(id: 1, description: "Cheese")
                    path.append(order)
                }
            }
            .navigationDestination(for: User.self) { user in
                Text("User Profile: \(user.name)")
            }
            .navigationDestination(for: Order.self) { order in
                ContentIsPresented(mainOrder: order)
            }
        }
    }
}

struct ContentIsPresented: View {
    let mainOrder: Order
    @State private var showDetails = false
    @State private var selectedItem: Order?

    var body: some View {
            VStack {
                Button("Show Main Order Details") {
                    selectedItem = mainOrder
                    showDetails = true
                }
                Button("Change Main Order Details") {
                    selectedItem = Order(id: 2, description: "Alternative")
                    showDetails = true
                }
            }
            .navigationDestination(isPresented: $showDetails) {
                if let item = selectedItem {
                    Text("Order Details: \(String(describing: item.description))")
                }
            }
    }
}

struct User: Hashable {
    let id: Int
    let name: String
}

struct Order: Hashable {
    let id: Int
    let description: String
}

#Preview {
    ContentView()
}
