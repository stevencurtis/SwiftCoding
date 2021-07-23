protocol Route {
    func moveToHomeScreen()
    func moveToSettings()
}

class IntroViewController: Route {
    func moveToHomeScreen() {
        // implementation
    }

    func moveToSettings() {
        // implementation
    }
}

class HomeViewController: Route {
    // not required in this case
    func moveToHomeScreen() {
        // implementation
    }

    func moveToSettings() {
        // implementation
    }
}
