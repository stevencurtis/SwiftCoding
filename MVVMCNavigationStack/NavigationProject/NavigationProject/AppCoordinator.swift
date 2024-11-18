import SwiftUI

final class AppCoordinator: ObservableObject {
    @Published private var navigationPath = NavigationPath()
    private let screenFactory: ScreenFactory

    init(screenFactory: ScreenFactory) {
        self.screenFactory = screenFactory
    }

    func start() -> some View {
        setupNavigationStack()
    }
    
    private func makeHomeView() -> some View {
        screenFactory.makeHomeView(coordinator: self)
    }
    
    private func setupNavigationStack() -> some View {
        NavigationStack(path: Binding(
            get: { self.navigationPath },
            set: { self.navigationPath = $0 }
        )) {
            makeHomeView()
                .navigationDestination(for: User.self) { user in
                    self.screenFactory.makeUserView(for: user)
                }
                .navigationDestination(for: Order.self) { order in
                    self.screenFactory.makeOrderView(for: order)
                }
        }
    }

    func goToUser(_ user: User) {
        navigationPath.append(user)
    }

    func goToOrder(_ order: Order) {
        navigationPath.append(order)
    }
}
