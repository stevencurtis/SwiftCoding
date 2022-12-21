//
//  DetailUIView.swift
//  StoryboardDelete
//
//  Created by Steven Curtis on 12/12/2022.
//

import UIKit

final class DetailUIView: UIView {
    let button = UIButton(type: .custom)

    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createSubviews()
    }

    func createSubviews() {
        self.backgroundColor = .orange
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 20)
        button.setTitle("Tap to dismiss view", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.isUserInteractionEnabled = true
        
        self.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        button.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.addSubview(button)
    }
}
