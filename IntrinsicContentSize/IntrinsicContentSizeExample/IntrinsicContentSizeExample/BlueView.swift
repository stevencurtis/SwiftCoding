//
//  BlueView.swift
//  IntrinsicContentSizeExample
//
//  Created by Steven Curtis on 19/07/2024.
//

import UIKit

@IBDesignable
final class BlueView: UIView {
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.backgroundColor = .blue
    }
    
    func setUpView() {
        self.backgroundColor = .blue
    }
}
