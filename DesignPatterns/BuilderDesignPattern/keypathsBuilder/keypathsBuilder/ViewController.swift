//
//  ViewController.swift
//  keypathsBuilder
//
//  Created by Steven Curtis on 26/10/2020.
//

import UIKit

protocol KeypathConfiguration {}

extension KeypathConfiguration where Self: AnyObject {
    func with<T>(_ property: ReferenceWritableKeyPath<Self, T>, setTo value: T) -> Self {
        self[keyPath: property] = value
        return self
    }
}

extension UIView: KeypathConfiguration {}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let label = UILabel()
            .with(\.textColor, setTo: .blue)
            .with(\.text, setTo: "This is a label")
            .with(\.textAlignment, setTo: .center)

        self.view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
}

