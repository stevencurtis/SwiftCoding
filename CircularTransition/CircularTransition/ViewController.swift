//
//  ViewController.swift
//  CircularTransition
//
//  Created by Steven Curtis on 21/08/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var navigationControllerDelegate: UINavigationControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationControllerDelegate = CircularCoordinator()
        self.navigationController?.delegate = navigationControllerDelegate
    }


    @IBAction func transitionAction(_ sender: UIButton) {
        performSegue(withIdentifier: "detail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {

        }
    }
}

