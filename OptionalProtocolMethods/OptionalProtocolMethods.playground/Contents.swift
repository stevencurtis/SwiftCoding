import UIKit

print("Optional protocol methods")
//protocol Route {
//    func moveToHomeScreen()
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
//    // not required in this case
//    func moveToHomeScreen() {
//        // implementation
//    }
//
//    func moveToSettings() {
//        // implementation
//    }
//}






//protocol Route {
//    func moveToHomeScreen()
//    func moveToSettings()
//}
//
//extension Route {
//    func moveToHomeScreen() {
//        // implementation
//    }
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
//    // not required in this case
//    func moveToHomeScreen() {
//        // implementation
//    }
//
//    func moveToSettings() {
//        // implementation
//    }
//}





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
