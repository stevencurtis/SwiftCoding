//
//  ViewController.swift
//  PassParameterTapGesture
//
//  Created by Steven Curtis on 25/09/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: SubclassedView!
    @IBOutlet weak var thirdView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        firstView.backgroundColor = .green
        secondView.backgroundColor = .blue
        thirdView.backgroundColor = .red
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(logToConsole))
        firstView.addGestureRecognizer(gesture)
        firstView.tag = 1
        
        let gestureTwo = UITapGestureRecognizer(target: self, action: #selector(logToConsole))
        secondView.addGestureRecognizer(gestureTwo)
        secondView.tag  = 2
        secondView.number = 2
        
        let gestureThree = SubclassedTapGestureRecognizer(target: self, action: #selector(logToConsoleCustom), number: 3)
        thirdView.addGestureRecognizer(gestureThree)
    }

    @objc func logToConsole(_ sender: UITapGestureRecognizer){
        print("The sender is : \(sender.view?.tag)")
        if let numberSender = sender.view as? SubclassedView {
            print("The sender is: \(numberSender.number)")
        }
    }
    
    @objc func logToConsoleCustom(_ sender: SubclassedTapGestureRecognizer){
        print(sender.number)
    }
}
