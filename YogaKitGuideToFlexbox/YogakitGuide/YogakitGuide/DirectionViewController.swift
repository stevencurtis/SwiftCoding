//
//  DirectionViewController.swift
//  YogakitGuide
//
//  Created by Steven Curtis on 12/07/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit
import FlexLayout


class DirectionViewController: UIViewController {
    
    fileprivate let scrollView = UIScrollView()
    fileprivate let rootFlexContainer = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        var items: [UIView] = []
        var colours: [UIColor] = [UIColor.blue,UIColor.brown, UIColor.green, UIColor.red, UIColor.purple]
        
        for i in 0...20 {
            let item = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            item.backgroundColor = colours[i % colours.count]
            let lab = UILabel(frame: item.frame)
            lab.text = i.description
            lab.textColor = (item.backgroundColor?.isDarkColor ?? true) ? UIColor.white : UIColor.black
            lab.font = lab.font.withSize(12)
            lab.textAlignment = .center
            
            item.addSubview(lab)
            items.append(item)
        }
        
        // outer container
        rootFlexContainer.flex.direction(.column).define { (flex) in
            let RowLabel = UILabel()
            RowLabel.text = "row: Default (left to right)"
            flex.addItem(RowLabel)
            // example of row, with the UIViews next to each other
            flex.addItem().direction(.row).justifyContent(.center).define { (flex) in
                for i in 0...4 {
                    flex.addItem(items[i]).margin(10)
                }
            }
            
            let reverseRowLabel = UILabel()
            reverseRowLabel.text = "rowReverse: right to left"
            flex.addItem(reverseRowLabel)
            // example of row, with the UIViews next to each other
            flex.addItem().direction(.rowReverse).justifyContent(.center).define { (flex) in
                for i in 5...9 {
                    flex.addItem(items[i]).margin(10)
                }
            }
            
            let columnLabel = UILabel()
            columnLabel.text = "column: Default (left to right)"
            flex.addItem(columnLabel)
            // example of column, with each UIView presented in a  vertical line
            flex.addItem().direction(.column).define { (flex) in
                for i in 10...14 {
                    flex.addItem(items[i]).margin(10).maxWidth(items[0].frame.width).maxHeight(items[0].frame.width).aspectRatio(1).alignSelf(.center)
                }
            }
            
            let reverseColumnLabel = UILabel()
            reverseColumnLabel.text = "columnReverse: right to left"
            flex.addItem(reverseColumnLabel)
            // example of column, with each UIView presented in a  vertical line
            flex.addItem().direction(.columnReverse).define { (flex) in
                for i in 15...19 {
                    flex.addItem(items[i]).margin(10).maxWidth(items[0].frame.width).maxHeight(items[0].frame.width).aspectRatio(1).alignSelf(.center)
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
