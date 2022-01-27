//
//  ViewController.swift
//  StaticFunctionClass
//
//  Created by Steven Curtis on 30/12/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        printThis(item: "test")
        let dave = Person(name: "Dave", age: 11)
        let result = dave.formattedPerson()
        
        let boilingPoint = 100.0
        let farenheit = boilingPoint.celsiusToFahrenheit()
        print("The boiling point in Farenhiet is \(farenheit)")
    }

    @IBAction func programmaticAction(_ sender: UIButton) {
        let viewController = ProgrammaticViewController()
        present(viewController, animated: true)
    }
}
