//
//  ViewController.swift
//  StepperApp
//
//  Created by Steven Curtis on 19/12/2020.
//

import UIKit

class ViewController: UIViewController {
    
    // Outlets connected to the UIStepper in the storyboard
    @IBOutlet weak var numberStepper: UIStepper!
    @IBAction func numberStepper(_ sender: UIStepper) {
        print (sender.value)
    }
    
    // Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponents()
        setupConstraints()
    }
    
    // Pertaining to the programmatic stepper
    var programaticStepper: UIStepper = UIStepper()
    func setupComponents() {
        // add the stepper to the view
        self.view.addSubview(programaticStepper)
        // we will take care of constraints
        programaticStepper.translatesAutoresizingMaskIntoConstraints = false
        // declare which function should be called when the stepper value is changed
        programaticStepper.addTarget(self, action: #selector(stepperChanged), for: .valueChanged)
        // Resume programaticStepper value from the beginning when it reaches the maximum
        programaticStepper.wraps = false
        // Set programaticStepper max value to 10
        programaticStepper.maximumValue = 10
        // If tap and hold the button, programaticStepper value will continuously increment
        programaticStepper.autorepeat = true
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // center the stepper horizontally and vertically
            programaticStepper.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            programaticStepper.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    @objc func stepperChanged(_ sender: UIStepper){
        print (sender.value)
    }
}
