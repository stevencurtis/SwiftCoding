//
//  ViewController.swift
//  GenerateMocks
//
//  Created by Steven Curtis on 27/12/2020.
//

import UIKit

class ViewController: UIViewController {
    let greeting: GreetingProtocol!
    init(greeting: GreetingProtocol) {
        self.greeting = greeting
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var basicLabel: UILabel = {
        let lab = UILabel()
        lab.text = "initial"
        return lab
    }()
  
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .red
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(basicLabel)
        basicLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            basicLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            basicLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        let hi = greeting.sayHello()
        print (hi)
        basicLabel.text = hi
    }
}
