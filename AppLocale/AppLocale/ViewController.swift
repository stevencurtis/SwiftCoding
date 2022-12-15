//
//  ViewController.swift
//  AppLocale
//
//  Created by Steven Curtis on 08/12/2022.
//

import UIKit

final class ViewController: UIViewController {
    let viewModel = ViewModel()
    @IBOutlet private var tempLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        logCurrentLocale()
        populateLabel()
    }
    
    func populateLabel() {
        tempLabel.text = viewModel.temperature()
    }
    
    func logCurrentLocale() {
        print(Locale.current.languageCode)
        print(Locale.current)
    }
}
