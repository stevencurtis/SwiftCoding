//
//  FirstViewController.swift
//  SegueDemo
//
//  Created by Steven Curtis on 09/04/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

protocol PassBackData {
    func dataBack(str: String)
}

class FirstViewController: UIViewController, PassBackData {
    @IBAction func unwindToFirstViewController(_ unwindSegue: UIStoryboardSegue) {
        _ = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
        // Do something
    }
    func dataBack(str: String) {
        print ("data sent back", str)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func moveButton(_ sender: UIButton) {
        performSegue(withIdentifier: "moveToSecond", sender: nil)
    }
    
    @IBAction func animatedButton(_ sender: UIButton) {
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "moveToSecond" {
            if let destination = segue.destination as? SecondViewController {
                destination.dataSent = "This is being Sent"
                destination.delegate = self
            }
        }
    }


}
