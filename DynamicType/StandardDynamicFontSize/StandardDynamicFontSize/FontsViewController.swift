//
//  FontsViewController.swift
//  StandardDynamicFontSize
//
//  Created by Steven Curtis on 28/09/2020.
//

import UIKit

class FontsViewController: UIViewController {

    @IBOutlet weak var dynamicTextLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDynamicTextLabelaAdjustsFontForContentSizeCategory()
    }
    
    func setupDynamicTextLabelaAdjustsFontForContentSizeCategory() {
        dynamicTextLabel.text = "this text size should change"
        if let font = UIFont(name: "Roboto-Regular", size: 16) {
            let fontMetrics = UIFontMetrics(forTextStyle: .headline)
            dynamicTextLabel.font = fontMetrics.scaledFont(for: font)
        }
        dynamicTextLabel.adjustsFontForContentSizeCategory = true
        dynamicTextLabel.numberOfLines = 0
    }
}
