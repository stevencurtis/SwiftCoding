protocol ScreenFactory {
    func makeHomeView(coordinator: AppCoordinator) -> HomeView
    func makeOrderView(for order: Order) -> OrderView
    func makeUserView(for user: User) -> UserView
}

final class DefaultScreenFactory: ScreenFactory {
    
    func makeHomeView(coordinator: AppCoordinator) -> HomeView {
        let viewModel = HomeViewModel(coordinator: coordinator)
        return HomeView(viewModel: viewModel)
    }
    
    func makeOrderView(for order: Order) -> OrderView {
        let viewModel = OrderViewModel(order: order)
        return OrderView(viewModel: viewModel)
    }
    
    func makeUserView(for user: User) -> UserView {
        let viewModel = UserViewModel(user: user)
        return UserView(viewModel: viewModel)
    }
}
