//
//  ViewController.swift
//  OperationQueueDependentAPICalls
//
//  Created by Steven Curtis on 09/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    let dataManager = DataManager()
    
    @IBAction func userListButtonAction(_ sender: UIButton) {
        dataManager.retrieveUserList(completionBlock: { data in
            DispatchQueue.main.async {
                self.textView.text = data.debugDescription
            }
        })
    }
    
    @IBAction func chainButtonAction(_ sender: UIButton) {
        dataManager.retrieveUserListThenUser(completionBlock: { data in
            DispatchQueue.main.async {
                self.textView.text = data.debugDescription
            }
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

