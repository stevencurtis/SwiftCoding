//
//  ViewController.swift
//  StackViewDemo
//
//  Created by Steven Curtis on 14/05/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var embeddedStackView: UIStackView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        mySV()
    }
    
    func mySV() {
        let myStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
        myStackView.alignment = .fill
        myStackView.distribution = .equalSpacing
        
        self.view.addSubview(myStackView)

        myStackView.translatesAutoresizingMaskIntoConstraints = false
        
        myStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        myStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        myStackView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
                
        let myView = UIView(frame: .zero)
        myView.backgroundColor = .purple
        myView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        myView.heightAnchor.constraint(equalTo: myView.widthAnchor).isActive = true
        myStackView.addArrangedSubview(myView)
        
        
        let myViewTwo = UIView(frame: .zero)
        myViewTwo.backgroundColor = .green
        myViewTwo.widthAnchor.constraint(equalToConstant: 100).isActive = true

        myViewTwo.heightAnchor.constraint(equalTo: myViewTwo.widthAnchor).isActive = true
        myStackView.addArrangedSubview(myViewTwo)
    }
}
