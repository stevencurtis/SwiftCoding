//
//  InstantiateViewController.swift
//  DependencyInjection
//
//  Created by Steven Curtis on 15/03/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class InstantiateViewController: UIViewController {
    
    var passedData : String?
    var delegate : ViewController?

    @IBOutlet weak var instantiateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let mess = passedData {
            instantiateLabel.text = mess
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
