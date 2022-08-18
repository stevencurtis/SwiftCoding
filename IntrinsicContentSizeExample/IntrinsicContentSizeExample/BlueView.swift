//
//  BlueView.swift
//  IntrinsicContentSizeExample
//
//  Created by Steven Curtis on 25/09/2020.
//

import UIKit

@IBDesignable
class BlueView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    func setUpView() {
        self.backgroundColor = .blue
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.backgroundColor = .blue
    }
}
