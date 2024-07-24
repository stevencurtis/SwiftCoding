//
//  ViewController.swift
//  IntrinsicContentSizeExample
//
//  Created by Steven Curtis on 19/07/2024.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet weak var simpleLabel: UILabel!
    @IBOutlet weak private var blueView: BlueView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Test"
        self.simpleLabel.text = "This is long text"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("view intrinsicContentSize \(self.view.intrinsicContentSize)")
        print("view frame \(self.view.frame)")
//        print("navigation bar intrinsicContentSize \(self.navigationController!.navigationBar.intrinsicContentSize)")
//        print("navigation bar frame \(self.navigationController!.navigationBar.frame)")
        
        print("simpleLabel intrinsicContentSize \(simpleLabel.intrinsicContentSize)")
        print("simpleLabel frame \(simpleLabel.frame)")
        
        print("blueview intrinsicContentSize \(blueView.intrinsicContentSize)")
        print("blueview frame \(blueView.frame)")
    }
}

