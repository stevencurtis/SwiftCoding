//
//  SecondViewController.swift
//  SegueDemo
//
//  Created by Steven Curtis on 09/04/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    var dataSent: String = "Not Set"
    var delegate: PassBackData?
    override func viewDidLoad() {
        super.viewDidLoad()
        print (dataSent)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.dataBack(str: "data sent back")
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
