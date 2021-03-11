//
//  SegueMVCViewController.swift
//  TestingInjectingServices
//
//  Created by Steven Curtis on 05/08/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class SegueMVCViewController: UIViewController {
    
    @IBOutlet weak var serviceLabel: UILabel!
    
    var serviceManager : ServiceManagerProtocol?

    var displayText : String  {
        return ServiceModel(serviceName: serviceManager!.getServiceName()).serviceName!
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _ = serviceManager {
            serviceLabel.text = displayText
        }
    }
}
