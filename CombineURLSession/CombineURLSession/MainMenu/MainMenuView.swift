//
//  MainMenu.swift
//  CombineURLSession
//
//  Created by Steven Curtis on 10/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class MainMenuView: UIView {
    @IBOutlet var view: UIView!

    @IBOutlet weak var logoutButton: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("MainMenuView", owner: self, options: .none)
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

    }

}
