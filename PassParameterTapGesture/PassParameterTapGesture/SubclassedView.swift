//
//  SubclassedView.swift
//  PassParameterTapGesture
//
//  Created by Steven Curtis on 25/09/2021.
//

import UIKit

class SubclassedView: UIView {
    var number: Int?
    // init from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    // init from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // common setup code
    private func setupView() {
        backgroundColor = .green
    }
}
