
protocol Route {
    func moveToHomeScreen()
    func moveToSettings()
}

extension Route {
    func moveToHomeScreen() {
        // implementation
    }
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


    func moveToSettings() {
        // implementation
    }
}





//@objc protocol Route {
//    @objc optional func moveToHomeScreen()
//    func moveToSettings()
//}
//
//class IntroViewController: Route {
//    func moveToHomeScreen() {
//        // implementation
//    }
//
//    func moveToSettings() {
//        // implementation
//    }
//}
//
//class HomeViewController: Route {
//    func moveToSettings() {
//        // implementation
//    }
//}

