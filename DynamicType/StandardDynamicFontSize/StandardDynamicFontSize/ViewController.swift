//
//  ViewController.swift
//  StandardDynamicFontSize
//
//  Created by Steven Curtis on 28/09/2020.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var dynamicTextLabel: UILabel!
    @IBOutlet weak var dynamicTextLabelObserver: UILabel!
    @IBOutlet weak var dynamicTextSizeCategory: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotDynamicLabel()
        setupDynamicTextLabelAdjustsFontForContentSizeCategory()
        setupdynamicTextLabelObserver()
        setupDynamicTextSizeCategory()

        NotificationCenter.default.addObserver(self, selector: #selector(preferredContentSizeChanged(_:)), name: UIContentSizeCategory.didChangeNotification, object: nil)
    }
    
    func setupNotDynamicLabel() {
        textLabel.text = "this text size should not change"
        textLabel.numberOfLines = 0
        textLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    }
    
    func setupDynamicTextLabelAdjustsFontForContentSizeCategory() {
        dynamicTextLabel.text = "this text size should change"
        dynamicTextLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        dynamicTextLabel.adjustsFontForContentSizeCategory = true
        dynamicTextLabel.numberOfLines = 0
    }
    
    func setupdynamicTextLabelObserver() {
        dynamicTextLabelObserver.text = "this text size should change using an observer"
        dynamicTextLabelObserver.font = UIFont.preferredFont(forTextStyle: .headline)
        dynamicTextLabelObserver.numberOfLines = 0
    }
    
    func setupDynamicTextSizeCategory() {
        dynamicTextSizeCategory.text = "this text size should change size category"
        dynamicTextSizeCategory.font = UIFont.preferredFont(forTextStyle: .headline)
        dynamicTextSizeCategory.numberOfLines = 0
    }
    
    @objc func preferredContentSizeChanged(_ notification: Notification) {
        dynamicTextLabelObserver.font = UIFont.preferredFont(forTextStyle: .headline)
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if previousTraitCollection?.preferredContentSizeCategory != traitCollection.preferredContentSizeCategory {
            dynamicTextSizeCategory.font = UIFont.preferredFont(forTextStyle: .headline)
        }
    }
    

}

