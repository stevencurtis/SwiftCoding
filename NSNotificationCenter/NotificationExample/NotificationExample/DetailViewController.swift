//
//  DetailViewController.swift
//  NotificationExample
//
//  Created by Steven Curtis on 07/04/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func optionA(_ sender: UIButton) {
        sendNotification(withString: "A")
    }
    
    @IBAction func optionB(_ sender: UIButton) {
        sendNotification(withString: "B")
    }
    
    func sendNotification (withString data: String) {
        let dict = ["sent": data]
        NotificationCenter.default.post(name: Notification.Name.dataModelDidUpdateNotification, object: self, userInfo: dict)
    }
    
}

extension Notification.Name {
    static let dataModelDidUpdateNotification = Notification.Name("NamedataModelDidUpdateNotification")
}

