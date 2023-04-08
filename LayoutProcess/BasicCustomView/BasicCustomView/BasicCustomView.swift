//
//  BasicCustomView.swift
//  BasicCustomView
//
//  Created by Steven Curtis on 16/01/2021.
//

import UIKit

class BasicCustomView: UIView {
    
    private var didSetupConstraints = false

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
      backgroundColor = .blue
    }


    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    // will run multiple times, so don't add new constraints but rather update the existing one
    override func updateConstraints() {
        if didSetupConstraints == false {
            configureAutolayoutConstraints()
        }
        
        super.updateConstraints()
    }
    
    // add constraints here
    private func configureAutolayoutConstraints () {
        
    }
    
    // we can alternatively use UIViewNoIntrinsicMetric
    final override var intrinsicContentSize: CGSize {
       return CGSize(width: 300, height: 200)
    }
    
    // opportunity to clean up before the class is deallocated
    deinit {
        
    }
}
