//
//  SBPickerProgrammaticViewController.swift
//  Pickers
//
//  Created by Steven Curtis on 03/08/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class SBPickerProgrammaticViewController: UIViewController {
    var hour: Int = 0
    var minutes: Int = 0
    var seconds: Int = 0
    
    var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            textField.heightAnchor.constraint(equalToConstant: 34),
            textField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9)
        ])
    }
    
    func setupTextField() {
        textField = UITextField(frame: .zero)
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
    }
    
    func setupPicker(){
        let pickerView = UIPickerView()
        pickerView.delegate = self
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
        toolBar.sizeToFit()
        
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.done))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        textField.inputView = pickerView
        textField.inputAccessoryView = toolBar
    }
    
    @objc func done() {
        view.endEditing(true)
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        setupTextField()
        setupConstraints()
        setupPicker()
    }
}

extension SBPickerProgrammaticViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 24
        case 1, 2:
            return 60
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.frame.size.width / 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(row) Hour"
        case 1:
            return "\(row) Minute"
        case 2:
            return "\(row) Second"
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            hour = row
        case 1:
            minutes = row
        case 2:
            seconds = row
        default:
            break
        }
    }
}
