//
//  ViewController.swift
//  DependencyInjection
//
//  Created by Steven Curtis on 15/03/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class ViewController: UIViewController, viewContData {
    @IBOutlet weak var initialViewLabel: UILabel!
    
    func recData(_ str: String) {
        initialViewLabel.text = str
    }
    
    @IBAction func injectionButton(_ sender: UIButton) {
        let destinationVC = DependencyInjectionViewController(display: "test")
        self.navigationController!.pushViewController(destinationVC, animated: false)
    }
    
    @IBAction func instantiateButton(_ sender: UIButton) {       
        let destinationVC = self.storyboard!.instantiateViewController(withIdentifier: "instantiate") as! InstantiateViewController
        destinationVC.passedData = "Comes from the inital view controller"
        destinationVC.delegate = self
        self.navigationController!.pushViewController(destinationVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueto" {
            let destinationVC = segue.destination as! SegueViewController
            destinationVC.passedData = "Comes from the inital view controller"
            destinationVC.delegate = self
        }
    }
    
    
}

