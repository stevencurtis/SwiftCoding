//
//  ViewController.swift
//  IntrinsicContentSizeExample
//
//  Created by Steven Curtis on 25/09/2020.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var blueView: BlueView!
    @IBOutlet weak var sampleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Test"
        self.sampleLabel.text = "This is long text"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("view intrinsicContentSize \(self.view.intrinsicContentSize)")
        print("view frame \(self.view.frame)")
        print("navigation bar intrinsicContentSize \(self.navigationController!.navigationBar.intrinsicContentSize)")
        print("navigation bar frame \(self.navigationController!.navigationBar.frame)")
        
        print("sampleLabel intrinsicContentSize \(sampleLabel.intrinsicContentSize)")
        print("sampleLabel frame \(sampleLabel.frame)")
        
        print("blueview intrinsicContentSize \(blueView.intrinsicContentSize)")
        print("blueview frame \(blueView.frame)")
    }
}
