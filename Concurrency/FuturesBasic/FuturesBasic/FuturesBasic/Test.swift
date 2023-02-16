import UIKit

class ErrorViewControllerDelegate {}

protocol ErrorController {
   func showError(_ error: String, isOnboarding: Bool)
}

extension  ErrorController {
   func showError(_ error: String) {
    showError(error)
   }
}

class ContactsViewController: UIViewController, ErrorController {
    func showError(_ error: String, isOnboarding: Bool) {
        //
    }
    
   func showError(_ error: String) {
      print(error)
   }
}

//let contacts: ErrorController = ContactsViewController()
//contacts.showError("I don't need a delegate.")
//contacts.showError("I need a delegate.", isOnboarding: true)
