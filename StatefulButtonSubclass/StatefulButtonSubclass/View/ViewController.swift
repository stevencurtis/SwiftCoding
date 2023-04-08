//
//  ViewController.swift
//  StatefulButtonSubclass
//
//  Created by Steven Curtis on 04/12/2020.
//

import UIKit

class ViewController: UIViewController {
    
    // the storyboard StatefulButton instance
    @IBOutlet weak var statefulButton: StatefulButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.statefulButton.setLoadingAction()
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.statefulButton.setEnabled()
        })
        
        self.statefulButton.whenButtonClicked { (status) in
            print ("VC status", status)
        }
        
        let createdInCodeButton = StatefulButton(text: "Set in code", loadingText: "Loading in code", color1: UIColor.green, color2: UIColor.orange, selectedColor1: UIColor.white, selectedColor2: UIColor.black, cornerRadius: 20, frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        view.addSubview(createdInCodeButton)
        createdInCodeButton.translatesAutoresizingMaskIntoConstraints = false
        createdInCodeButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        createdInCodeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        createdInCodeButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        createdInCodeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        createdInCodeButton.setEnabled()
        createdInCodeButton.whenButtonClicked { (status) in
            print ("VC status", status)
        }
    }

}
