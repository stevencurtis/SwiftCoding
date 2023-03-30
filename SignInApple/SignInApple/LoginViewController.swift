//
//  LoginViewController.swift
//  SignInApple
//
//  Created by Steven Curtis on 25/11/2020.
//

import UIKit
import AuthenticationServices

class LoginViewController: UIViewController {
    
    // create the Sign in with AppleID button
    let authorizationButton = ASAuthorizationAppleIDButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add a target for the UIButton
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        
        // add the UIButton
        self.view.addSubview(authorizationButton)
        
        // let the code that has been defined in this class set up the constraints
        authorizationButton.translatesAutoresizingMaskIntoConstraints = false
        
        // call the function that sets up the constraints
        setupConstraints()
    }
    
    // create the constraints for the button against the parent view
    func setupConstraints() {
        NSLayoutConstraint.activate([
            authorizationButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            authorizationButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 100)
        ])
    }
    
    // an objective-c function for handling the users' button press
    @objc
    func handleAuthorizationAppleIDButtonPress() {
        // setup the class to authenticate users using the AppleID
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        // ask the authentication class to create the request
        let request = appleIDProvider.createRequest()
        // request the contact information, from a choice of the full name and email
        request.requestedScopes = [.fullName, .email]
        
        // Controller to manage the authorization requests
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        // who to inform about the success or failure of the authorization
        authorizationController.delegate = self
        // present the authorization interface
        authorizationController.presentationContextProvider = self
        // perform the authorization requests
        authorizationController.performRequests()
    }
    
}

// information about the outcome (success / failure) of the authorization request
extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // handle error, it is also possible the user cancelled this action
        print (error)
    }
    // this is fired when the authorization is completed successfully
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        // authorization is an ASAuthorization property, allowing access to credentials
        // which are then used to send to the backend for the authorization flow
        
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            // optional JWT token
            if let authorizationCode = appleIDCredential.authorizationCode,
               let identifyToken = appleIDCredential.identityToken {
                let userIdentifier = appleIDCredential.user
                //appleIDCredential.fullName // optional, if initial login
                // appleIDCredential.email // optional, if initial login
                //initial login, submit authorization code and identity token to the
                //backnd for validation along with email and fullName
                //TODO: Submit authorization code and identity token to the backend
                //TODO: Perform user login when a success received from the backend
                return
            }
        case let passwordCredential as ASPasswordCredential:
            // The user selects credentials which are already stored in the iCloud Keychain
            // passwordCredential.user
            // passwordCredential.password
            // call the server and check the username and password
            // the server and flow is outside the scope of this tutorial
            return
        default:
            break
        }
    }    
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    //Tells the delegate from which window it should present the authorization interface to the user.
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        // force-unwrap because at this point the view must have a window
        return self.view.window!
    }
}
