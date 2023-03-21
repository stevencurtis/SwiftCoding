//
//  SimpleView.swift
//  SnapshotViews
//
//  Created by Steven Curtis on 22/10/2020.
//

import UIKit

class SimpleView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .green
        let lab = UILabel()
        lab.text = "Hello, World!"
        lab.frame = self.frame
        self.addSubview(lab)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
}
