//
//  ViewController.swift
//  IBSegueActionProject
//
//  Created by Steven Curtis on 17/07/2023.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    @IBAction func buttonAction() {
        performSegue(withIdentifier: "first", sender: nil)
    }
    
    @IBAction func secondButtonAction() {
        performSegue(withIdentifier: "second", sender: nil)
    }
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "first" {
            let destination = segue.destination as? SecondViewController
            destination?.myNum = 2
        } else if segue.identifier == "second" {
            let destination = segue.destination as? ThirdViewController
            destination?.myNum = 3
        }
    }
}
