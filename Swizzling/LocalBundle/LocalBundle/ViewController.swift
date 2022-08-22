//
//  ViewController.swift
//  LocalBundle
//
//  Created by Steven Curtis on 01/10/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import FlexLayout
import RxSwift
import UIKit

class ViewController: UIViewController {
    
    var targetLabel: UILabel!
    var targetButton: UIButton!
    
    fileprivate let scrollView = UIScrollView()
    fileprivate let rootFlexContainer = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        createComponents()
        setupLayout()
        applyTranslationsFromBundle()
    }
    
    func createComponents() {
        targetLabel = UILabel()
        targetLabel.text = "welcome_screen_title"
        targetLabel.numberOfLines = 0
        
        targetButton = UIButton()
        targetButton.setTitle("Test Button", for: .normal)
        targetButton.setTitleColor(.red, for: .normal)
        targetButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    func setupLayout() {
        rootFlexContainer.flex.direction(.column).justifyContent(.center).padding(12).define { flex in
            flex.addItem(targetLabel).margin(10.0)
            flex.addItem(targetButton).margin(10.0)
        }
        
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.addSubview(rootFlexContainer)
    }
    
    @objc func buttonAction() {
        print ("button action")
    }

    func applyTranslationsFromBundle() {        
        targetLabel.text = NSLocalizedString("welcome_screen_title", comment: "")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.flex.layout(mode: .fitContainer)
        rootFlexContainer.flex.layout(mode: .fitContainer)
        scrollView.contentSize = rootFlexContainer.frame.size
    }
}
