//
//  RegistrationViewController.swift
//  CombineURLSession
//
//  Created by Steven Curtis on 09/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit
import Combine

class RegistrationViewController: UIViewController {
    var registrationViewModel: RegistrationViewModelProtocol?
    var registerView = RegisterView()
    var matchSub: AnyCancellable?
    var regSub: AnyCancellable?

    private var subscriptions = Set<AnyCancellable>()


    init(viewModel: RegistrationViewModelProtocol = RegistrationViewModel(
        networkManager: HTTPManager(session: URLSession.shared),
        userdatamanager: UserDataManager()
        )
    )
    {
        super.init(nibName: nil, bundle: nil)
        registrationViewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        // This implementation does not use the Storyboard
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        
        regSub = registrationViewModel?.validPassword
            .receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: registerView.registerButton)
        
        setupBindings()
    }
    
    private func setupBindings() {
        registrationViewModel?.shouldNav
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
        self.view = registerView
        registerView.registerButton.addTarget(
            self,
            action: #selector(didPressRegister),
            for: .touchUpInside)
        
        registerView.passwordTextField.addTarget(
            self,
            action: #selector(self.passwordTextFieldDidChange(_:)),
            for: .editingChanged)
        
        registerView.retypePasswordTextField.addTarget(
            self,
            action: #selector(self.retypePasswordTextFieldDidChange(_:)),
            for: .editingChanged)
    }
    
    @objc func passwordTextFieldDidChange(_ sender: UITextField) {
        registrationViewModel?.password = sender.text ?? ""
        
        matchSub = registrationViewModel?.validMatchPassword
            .receive(on: RunLoop.main)
            .assign(to: \.pwMatch, on: registerView)
    }
    
    @objc func retypePasswordTextFieldDidChange(_ sender: UITextField) {
        registrationViewModel?.repeatPassword = sender.text ?? ""
        
        matchSub = registrationViewModel?.validMatchPassword
            .receive(on: RunLoop.main)
            .assign(to: \.pwMatch, on: registerView)
    }
    
    @objc func userNameTextFieldDidChange(_ sender: UITextField) {
        registrationViewModel?.userName = sender.text ?? ""
    }
    
    @objc
    private func didPressRegister() {
        // Resistation 
        print ("register")
        registrationViewModel?.register()
    }
}
