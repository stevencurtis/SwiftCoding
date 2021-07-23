protocol HomeRoute {
    func moveToHomeScreen()
}

protocol SettingsRoute {
    func moveToSettings()
}

class IntroViewController: HomeRoute, SettingsRoute {
    func moveToHomeScreen() {
        // implementation
    }
    
    func moveToSettings() {
        // implementation
    }
}

class HomeViewController: SettingsRoute {
    func moveToSettings() {
        // implementation
    }
}


