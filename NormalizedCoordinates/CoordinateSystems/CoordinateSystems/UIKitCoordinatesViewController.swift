//
//  UIKitCoordinatesViewController.swift
//  CoordinateSystems
//
//  Created by Steven Curtis on 28/12/2021.
//

import UIKit

class UIKitCoordinatesViewController: UIViewController {

    @IBOutlet private weak var subView: SubclassedView!
    
    @IBOutlet weak var viewControllerLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
        setupTap()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupSubview() {
        subView.backgroundColor = .blue
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleSubviewTap(_:)))
        subView.addGestureRecognizer(tap)
        
        subView.closure = { str in
            self.blueLabel.text = str
        }
    }
    
    func setupTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let touchPoint = sender.location(in: self.view)
        viewControllerLabel.text = touchPoint.debugDescription
    }
    
    @objc func handleSubviewTap(_ sender: UITapGestureRecognizer) {
        let touchPoint = sender.location(in: subView)
        print(touchPoint)
    }
}
