//
//  GrowViewController.swift
//  YogakitGuide
//
//  Created by Steven Curtis on 13/07/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit
import FlexLayout

class GrowViewController: UIViewController {
    
    fileprivate let scrollView = UIScrollView()
    fileprivate let rootFlexContainer = UIView()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        var items: [UIView] = []
        var colours: [UIColor] = [UIColor.blue,UIColor.brown, UIColor.green, UIColor.red, UIColor.purple]
        
        
        for i in 0...5 {
            let item = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            item.backgroundColor = colours[i % colours.count]
            let lab = UILabel(frame: item.frame)
            lab.text = "1"
            if i == 4 {lab.text = "2"}
            lab.textColor = (item.backgroundColor?.isDarkColor ?? true) ? UIColor.white : UIColor.black
            lab.font = lab.font.withSize(12)
            lab.textAlignment = .center
            
            item.addSubview(lab)
            items.append(item)
        }
        
        
        rootFlexContainer.flex.direction(.column).padding(100).define { (flex) in

            
            flex.addItem().direction(.column).define{ (flex) in
                let rowWrapLabel = UILabel()
                rowWrapLabel.numberOfLines = 0
                rowWrapLabel.text = "Equal grow for each item"
                flex.addItem(rowWrapLabel)
                flex.addItem().wrap(.wrap).direction(.row).define { (flex) in
                    flex.addItem(items[0]).margin(10).grow(1)
                    flex.addItem(items[1]).margin(10).grow(1)
                    flex.addItem(items[2]).margin(10).grow(1)
                }
            }
            
            
            flex.addItem().direction(.column).define{ (flex) in
                let rowWrapLabel = UILabel()
                rowWrapLabel.numberOfLines = 0
                rowWrapLabel.text = "Equal grow for each item"
                flex.addItem(rowWrapLabel)
                flex.addItem().wrap(.wrap).direction(.row).define { (flex) in
                    flex.addItem(items[3]).margin(10).grow(1)
                    flex.addItem(items[4]).margin(10).grow(2)
                    flex.addItem(items[5]).margin(10).grow(1)
                }
            }
            
        }
        
        
        
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
    


}
