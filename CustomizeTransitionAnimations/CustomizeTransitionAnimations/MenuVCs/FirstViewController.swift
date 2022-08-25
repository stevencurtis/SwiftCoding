//
//  ViewController.swift
//  CustomizeTransitionAnimations
//
//  Created by Steven Curtis on 17/08/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func goToSecondVC(_ sender: UIButton) {
        performSegue(withIdentifier: "moveToSecond", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveToSecond" {
            if let destination = segue.destination as? SecondViewController {
                destination.dataSent = "This is being sent"
            }
        }
    }
    
    let transitionDelegate: UIViewControllerTransitioningDelegate = TransitionDelegate()
    
    @IBAction func goToSecondVCProgramatically(_ sender: UIButton) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController
        {
            present(vc, animated: true, completion: nil)
        }
    }
    
    
    // this can be named as anything
    @IBAction func unwindToFirst( _ seg: UIStoryboardSegue) {
    }

}

