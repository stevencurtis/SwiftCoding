//
//  ViewController.swift
//  CustomAlertView
//
//  Created by Steven Curtis on 06/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var alert: AlertViewController?


    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        alert = UIStoryboard(name: Constants.alertStoryBoard, bundle: nil).instantiateViewController(withIdentifier: Constants.alerts.mainAlert) as? AlertViewController
        alert?.title = "Enter your task"
        alert?.presentToWindow()
        alert?.delegate = self
    }
}

extension ViewController: AlertsDelegate {
    func textValue(textFieldValue: String) {
        // textFieldValue returned to the caller, perhaps
        // save to core data or
        // reload a table
    }
}

