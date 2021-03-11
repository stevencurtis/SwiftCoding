//
//  ViewController.swift
//  LocalizeSwiftTutorial
//
//  Created by Steven Curtis on 10/07/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

import Localize_Swift

let label = UILabel(frame: .zero)
let button = UIButton(frame: .zero)

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Hello World".localized()
        
        print ("languages:", Localize.availableLanguages())
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(equalToConstant: 200.0),
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            ])
        
        button.setTitle("Choose language", for: .normal)
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(changeLanguage(_:)), for: .touchUpInside)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 200.0),
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.topAnchor.constraint(equalTo: label.bottomAnchor)
            ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(setText), name: NSNotification.Name( LCLLanguageChangeNotification), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func setText(){
        label.text = "Hello World".localized()
    }

    @IBAction func resetLanguage(_ sender: AnyObject) {
        Localize.resetCurrentLanguageToDefault()
    }
    
    @IBAction func changeLanguage(_ sender: AnyObject) {
        let actionSheet = UIAlertController(title: nil, message: "Switch Language", preferredStyle: UIAlertController.Style.actionSheet)
        for language in Localize.availableLanguages() where language != "Base" {
            let displayName = Localize.displayNameForLanguage(language)
            let languageAction = UIAlertAction(title: displayName, style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                Localize.setCurrentLanguage(language)
            })
            actionSheet.addAction(languageAction)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: {
            (alert: UIAlertAction) -> Void in
        })
        actionSheet.addAction(cancelAction)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
}

