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
        } else if segue.identifier == "second" {
            let destination = segue.destination as? ThirdViewController
            destination?.myNum = 3
        }
    }
    
    @IBSegueAction func test(_ coder: NSCoder) -> SecondViewController? {
        let viewController = SecondViewController(myNum: 7, coder: coder)
        return viewController
    }
    
    @IBSegueAction func testTwo(_ coder: NSCoder, sender: Any?, segueIdentifier: String?) -> ThirdViewController? {
        print(sender, segueIdentifier) // nil, second
        let viewController = ThirdViewController(myNum: 8, coder: coder)
        return viewController
    }
}
