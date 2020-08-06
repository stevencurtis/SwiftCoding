//
//  RegisterView.swift
//  CombineURLSession
//
//  Created by Steven Curtis on 09/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class RegisterView: UIView {
    @IBOutlet var view: UIView!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var retypePasswordTextField: UITextField!
    @IBOutlet weak var passwordMatchError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var usernameError: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    var pwMatch = false {
        didSet {
            print (pwMatch)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {         UIView.animate(withDuration: 1.0, animations: {
                self.passwordMatchError.isHidden = self.pwMatch
            })
            }
        }
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("RegisterView", owner: self, options: .none)
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.passwordError.isHidden = true
        self.usernameError.isHidden = true
        self.passwordMatchError.isHidden = true
    }
}
