//
//  ViewController.swift
//  NotificationExample
//
//  Created by Steven Curtis on 07/04/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector( notificationReceived(withNotification:) ), name: Notification.Name.dataModelDidUpdateNotification, object: nil)
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        // NotificationCenter.default.removeObserver(self)
    }
    
    @objc func notificationReceived (withNotification notification: NSNotification) {
        if let prog = notification.userInfo?["sent"] as? String {
            let lab = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50  ))
            lab.textAlignment = .center
            lab.text = prog
            stackView.addArrangedSubview(lab)
            stackView.translatesAutoresizingMaskIntoConstraints = false
        }
    }


}

