//
//  ViewController.swift
//  CombineURLSession
//
//  Created by Steven Curtis on 08/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit
import Foundation
import Combine
class LoginViewController: UIViewController {
    var loginViewModel: LoginViewModelProtocol?
    var loginView = LoginView()
    
    var unSub: AnyCancellable?
    var loginSub: AnyCancellable?
    var animSub: AnyCancellable?
    var validationSub: AnyCancellable?
    
    private var subscriptions = Set<AnyCancellable>()
    
    private var buttonPublisher: AnyPublisher<Void, Never>?
    
    init(viewModel: LoginViewModelProtocol = LoginViewModel(
        networkManager: HTTPManager(session: URLSession.shared),
        userdatamanager: UserDataManager()
        )
    )
    {
        super.init(nibName: nil, bundle: nil)
        loginViewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        // This implementation does not use the Storyboard
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupBindings() {
        loginViewModel?.shouldNav
            .sink(receiveCompletion: { completion in
                // Handle the error
                print ("completion\(completion)")
            }) { [weak self] _ in
                let mvc = MainMenuViewController()
                self?.navigationController?.pushViewController(mvc, animated: true)
        }.store(in: &subscriptions)
    }
    
    override func loadView() {
        // RegisterView is from the Storyboard!
        // Tightly coupled, but this is `just` a UIView
        self.view = loginView
        
        loginView.loginButton.addTarget(self, action: #selector(didPressLogin), for: .touchUpInside)
        
        loginView.registerButton.addTarget(self, action: #selector(didPressRegister), for: .touchUpInside)
        
        loginView.userNameTextField.addTarget(self, action: #selector(self.userNameTextFieldDidChange(_:)), for: .editingChanged)
        
        loginView.userNameTextField.addTarget(self, action: #selector(self.userNameTextFieldDidEnd(_:)), for: .editingDidEnd)
        
        loginView.passwordTextField.addTarget(self, action: #selector(self.passwordTextFieldDidChange(_:)), for: .editingChanged)
        
        loginView.passwordTextField.addTarget(self, action: #selector(self.passwordTextFieldDidEnd(_:)), for: .editingDidEnd)
    }
    
    @objc
    private func didPressLogin() {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        window?.startIndicatingActivity()
        loginViewModel?.login()
    }
    
    @objc
    private func didPressRegister() {
        let rvc = RegistrationViewController()
        self.navigationController?.pushViewController(rvc, animated: true)
    }
    
    @objc func passwordTextFieldDidChange(_ sender: UITextField) {
        loginViewModel?.password = sender.text ?? ""
    }
    
    @objc func passwordTextFieldDidEnd(_ sender: UITextField) {
        animSub = loginViewModel?.validLengthPassword
            .receive(on: RunLoop.main)
            .assign(to: \.pwVisibility, on: loginView)
    }
    
    @objc func userNameTextFieldDidChange(_ sender: UITextField) {
        loginViewModel?.username = sender.text ?? ""
    }
    
    @objc func userNameTextFieldDidEnd(_ sender: UITextField) {
        unSub = loginViewModel?.validLengthUsername
            .receive(on: RunLoop.main)
            .assign(to: \.unVisibility, on: loginView)
        
        validationSub = loginViewModel?.userValidation
            .receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: loginView.loginButton)
    }
}
