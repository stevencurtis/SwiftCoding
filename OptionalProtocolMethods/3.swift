@objc protocol Route {
    @objc optional func moveToHomeScreen()
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
    func moveToSettings() {
        // implementation
    }
}
