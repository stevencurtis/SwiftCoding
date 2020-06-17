//
//  Subclassed.swift
//  UIViewSubclassXIB
//
//  Created by Steven Curtis on 02/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class SubclassedView: UIView {
    @IBOutlet var subclassedView: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("Subclassed", owner: self, options: .none)
        addSubview(subclassedView)
        subclassedView.frame = self.bounds
        subclassedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}




