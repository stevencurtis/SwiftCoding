//
//  AlertViewController.swift
//  CoreDataToDo
//
//  Created by Steven Curtis on 13/06/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {

    var maintext : NSAttributedString?
    var delegate : AlertsDelegate?
   
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var buttonView: UIView!
    
    @IBOutlet weak var inputTextView: UITextField!
    
    @IBAction func textViewDone(_ sender: UITextField) {
        delegate?.textValue(textFieldValue: inputTextView.text ?? "")
        sender.resignFirstResponder()
    }
    
    @IBAction func OKButtonPressed(_ sender: UIButton) {
        delegate?.textValue(textFieldValue: inputTextView.text ?? "")
        self.view.removeFromSuperview()
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.view.removeFromSuperview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        
        titleLabel.text = title
        
        self.view.backgroundColor = Constants.alerts.grayColor
        self.alertView.backgroundColor = Constants.alerts.bgColor
        self.alertView.layer.cornerRadius = 15

        let border = CALayer()
        border.backgroundColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0,y: 0, width: alertView.frame.size.width, height: 1.0)
        self.buttonView.layer.addSublayer(border)
        
        self.buttonView.clipsToBounds = true
        self.buttonView.layer.cornerRadius = 15
        self.buttonView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }

}

extension AlertViewController {
    func presentToWindow() {
        let window = UIApplication.shared.keyWindow!
        let newFrame = CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height)
        self.view.frame = newFrame
        window.addSubview((self.view)!)
    }
}

