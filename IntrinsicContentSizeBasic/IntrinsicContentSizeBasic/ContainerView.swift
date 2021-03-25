//
//  ContainerView.swift
//  IntrinsicContentSizeBasic
//
//  Created by Steven Curtis on 16/01/2021.
//

import UIKit

final class ContainerView: UIView {
    
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
    
    override var intrinsicContentSize: CGSize {
       return CGSize(width: 200, height: 300)
    }
}
