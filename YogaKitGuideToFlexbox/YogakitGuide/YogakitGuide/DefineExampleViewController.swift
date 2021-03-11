//
//  DefineExampleViewController.swift
//  YogakitGuide
//
//  Created by Steven Curtis on 12/07/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit
import FlexLayout

class DefineExampleViewController: UIViewController {
    
//    fileprivate let rootFlexContainer = UIView()

    // This define example shows how closures can be used, as well as making a responsive design
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }

    override func viewDidLoad() {
        
//        This method is used to structure your code so that it matches the flexbox structure. The method has a closure parameter with a single parameter called flex. This parameter is in fact the view's flex interface. It can be used to adds other flex items and containers.
        
        // For simplicity, this view does NOT resize the subviews on rotation!

        super.viewDidLoad()
        let image = UIImage(named: "placeholder") //  placeholder
        let imageView = UIImageView(image: image)

        
        let titleLabel = UILabel()
        titleLabel.text = "Title"
        titleLabel.backgroundColor = .lightGray
        
        let priceLabel = UILabel()
        priceLabel.text = "Price"
        priceLabel.backgroundColor = .blue
        
        let backBtn = UIButton(type: .roundedRect)
        backBtn.setTitle("Back", for: .normal)
        backBtn.addTarget(self, action: #selector(back), for: .touchUpInside)
        

        view.flex.direction(.column).padding(50).define { (flex) in
            flex.addItem(imageView).maxWidth(100%).aspectRatio(of: imageView)
            // Row container
            flex.addItem().direction(.row).define { (flex) in
                    flex.addItem(titleLabel).grow(1)
                    flex.addItem(priceLabel).grow(1)
            }
            flex.addItem(backBtn)
        }
        
        let imageViewNoDefine = UIImageView(image: image)
        
        let titleLabelNoDefine = UILabel()
        titleLabelNoDefine.text = "Title"
        titleLabelNoDefine.backgroundColor = .lightGray
        
        let priceLabelNoDefine = UILabel()
        priceLabelNoDefine.text = "Price"
        priceLabelNoDefine.backgroundColor = .blue
        
        let backBtnNoDefine = UIButton(type: .roundedRect)
        backBtnNoDefine.setTitle("Back", for: .normal)
        backBtnNoDefine.addTarget(self, action: #selector(back), for: .touchUpInside)
        
        
        let columnContainer = UIView()
        columnContainer.flex.addItem(imageViewNoDefine).maxWidth(100%).aspectRatio(of: imageViewNoDefine)
        view.flex.addItem(columnContainer)
        
        let rowContainer = UIView()
        rowContainer.flex.direction(.row)
        rowContainer.flex.addItem(titleLabelNoDefine).grow(1)
        rowContainer.flex.addItem(priceLabelNoDefine).grow(1)
        
        columnContainer.flex.addItem(backBtnNoDefine)
        columnContainer.flex.addItem(rowContainer)

        view.backgroundColor = .red
       

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.flex.layout(mode: .fitContainer)
    }

    @objc func back() {
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.isNavigationBarHidden = false

    }
    

}
