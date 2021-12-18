//
//  SBNoTextFieldController.swift
//  Pickers
//
//  Created by Steven Curtis on 03/08/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class SBNoTextFieldController: UIViewController {
    var hour: Int = 0
    var minutes: Int = 0
    var seconds: Int = 0
    
    var pickerView: UIView!
    var picker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.done))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        pickerView = UIView(frame: CGRect(x: 0, y: view.frame.height + 260, width: view.frame.width, height: 260))
        
        view.addSubview(pickerView)
        
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pickerView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            pickerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 260),
            pickerView.heightAnchor.constraint(equalToConstant: 260)
        ])
        
        pickerView.backgroundColor = .white
        
        picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 260))
        pickerView.addSubview(picker)
        
        picker.isUserInteractionEnabled = true
        pickerView.addSubview(toolBar)
        
        picker.delegate = self
        picker.dataSource = self
    }
    
    func appearPickerView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.pickerView.frame = CGRect(x: 0, y: self.view.bounds.height - self.pickerView.bounds.size.height, width: self.pickerView.bounds.size.width, height: self.pickerView.bounds.size.height)
        })
    }
    
    func disappearPickerView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.pickerView.frame = CGRect(x: 0, y: self.view.bounds.height, width: self.pickerView.bounds.size.width, height: self.pickerView.bounds.size.height)
        })
    }
    
    func setupPicker(){
        let pickerView = UIPickerView()
        pickerView.delegate = self
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
        toolBar.sizeToFit()
        
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.done))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
    }
    
    @IBAction func appearPickerAction(_ sender: UIButton) {
        appearPickerView()
    }
    
    @objc func done() {
        view.endEditing(true)
        disappearPickerView()
    }
}

extension SBNoTextFieldController: UIPickerViewDelegate, UIPickerViewDataSource {
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
        return pickerView.frame.size.width/3
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
