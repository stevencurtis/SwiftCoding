//
//  LoginView.swift
//  CombineURLSession
//
//  Created by Steven Curtis on 08/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit
import Combine

class LoginView: UIView {
    @IBOutlet var view: LoginView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userNameError: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    var unVisibility = false {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {         UIView.animate(withDuration: 1.0, animations: {
                self.userNameError.isHidden = self.unVisibility
            })
            }
        }
    }
    
    var pwVisibility = false {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {         UIView.animate(withDuration: 1.0, animations: {
                self.passwordError.isHidden = self.pwVisibility
            })
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("LoginView", owner: self, options: .none)
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        userNameTextField.delegate = self
        
        // There is no error when we first load
        self.userNameError.isHidden = true
        self.passwordError.isHidden = true
        
        self.userNameError.text = "Username Must be > \(passwordLength) characters"
        self.passwordError.text = "Password Must be > \(passwordLength) characters"
        
        // and the login button will be disabled
        self.loginButton.isEnabled = false
    }

}

extension LoginView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // output entire chenge from UITextField
        // print (textField.text, string)
        return true
    }
}
