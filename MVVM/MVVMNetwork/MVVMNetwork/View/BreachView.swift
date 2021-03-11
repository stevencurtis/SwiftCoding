//
//  BreachView.swift
//  MVVMNetwork
//
//  Created by Steven Curtis on 13/04/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class BreachView: UIView {
    var nameLabel = UILabel()
    public override init(frame: CGRect) {
        let labelframe = CGRect(x: 0, y: 50, width: frame.width, height: 20)
        nameLabel.frame = labelframe
        nameLabel.backgroundColor = .gray
        super.init(frame: frame)
        self.addSubview(nameLabel)
        backgroundColor = .red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
