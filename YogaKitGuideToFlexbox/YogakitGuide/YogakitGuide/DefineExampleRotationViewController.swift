//
//  DefineExampleRotationViewController.swift
//  YogakitGuide
//
//  Created by Steven Curtis on 12/07/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit
import FlexLayout


class DefineExampleRotationViewController: UIViewController {
    
    //    fileprivate let rootFlexContainer = UIView()
    
    fileprivate let scrollView = UIScrollView()
    fileprivate let rootFlexContainer = UIView()
    
    // This method is used to structure your code so that it matches the flexbox structure. The method has a closure parameter with a single parameter called flex. This parameter is in fact the view's flex interface. It can be used to adds other flex items and containers.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

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

        rootFlexContainer.flex.direction(.column).padding(50).define { (flex) in
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
        rootFlexContainer.flex.addItem(columnContainer)
        
        let rowContainer = UIView()
        rowContainer.flex.direction(.row)
        rowContainer.flex.addItem(titleLabelNoDefine).grow(1)
        rowContainer.flex.addItem(priceLabelNoDefine).grow(1)
        
        columnContainer.flex.addItem(backBtnNoDefine)
        columnContainer.flex.addItem(rowContainer)

        
        // colours here can make it easier to understand what is going on in the view
//        scrollView.backgroundColor = .purple
//        rootFlexContainer.backgroundColor = .green
//        view.backgroundColor = .red

        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        scrollView.addSubview(rootFlexContainer)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.flex.layout(mode: .fitContainer)
        rootFlexContainer.flex.layout(mode: .fitContainer)
        scrollView.contentSize = rootFlexContainer.frame.size
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
