import SwiftUI

final class HomeViewModel: ObservableObject {
    private let coordinator: AppCoordinator

    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }

    func navigateToUser() {
        let user = User(id: 1, name: "Ahmed")
        coordinator.goToUser(user)
    }

    func navigateToOrder() {
        let order = Order(id: 1, description: "Cheese")
        coordinator.goToOrder(order)
    }
}
