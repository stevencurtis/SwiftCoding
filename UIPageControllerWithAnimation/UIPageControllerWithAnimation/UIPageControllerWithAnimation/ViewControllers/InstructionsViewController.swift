//
//  InstructionsViewController.swift
//  UIPageControllerWithAnimation
//
//  Created by Steven Curtis on 28/05/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class InstructionsViewController: UIViewController {
    
    
    fileprivate var mainText: String?
    fileprivate var image: String?
    fileprivate var mainTitle: String?
    
    fileprivate var bgColor: UIColor?
    fileprivate var fgColor: UIColor?
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var bottomColorBar: UIImageView!
    
    func setupVC(title: String, mainText: String, imageName: String, bgColor: UIColor, fgColor: UIColor) {
        self.mainText = mainText
        self.mainTitle = title
        self.image = imageName
        self.bgColor = bgColor
        self.fgColor = fgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = mainTitle
        contentLabel.text = mainText
        imageView.image = UIImage(named: image ?? "placeholder")
        view.backgroundColor = bgColor
        bottomColorBar.backgroundColor = fgColor
    }
    
    @IBAction func nextButtonAction(_ sender: UIButton) {
        var candidate: UIViewController = self
        while true {
            if let pageViewController = candidate as? PageViewController {
                pageViewController.goNextPage()
                break
            }
            guard let next = parent else { break }
            candidate = next
        }
    }
    
}
