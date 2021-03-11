//
//  SegueViewController.swift
//  DependencyInjection
//
//  Created by Steven Curtis on 15/03/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

protocol viewContData {
    func recData(_ str: String)
}

class SegueViewController: UIViewController {
    
    @IBOutlet weak var segueLabel: UILabel!
    
    var passedData : String!
    var delegate : ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let mess = passedData {
            segueLabel.text = mess
        }
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(SegueViewController.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
    }
    
    @IBAction func passDataBack(_ sender: UIButton) {
        delegate?.recData("back from segue view controller")
    }
    
    @objc func back(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    
}
