//
//  WrapViewController.swift
//  YogakitGuide
//
//  Created by Steven Curtis on 12/07/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit
import FlexLayout

class WrapViewController: UIViewController {

    fileprivate let scrollView = UIScrollView()
    fileprivate let rootFlexContainer = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        var items: [UIView] = []
        var colours: [UIColor] = [UIColor.blue,UIColor.brown, UIColor.green, UIColor.red, UIColor.purple]      
        
        for i in 0...119 {
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
        
        rootFlexContainer.flex.direction(.column).define { (flex) in
            
            flex.addItem().direction(.column).define{ (flex) in
                let rowLabel = UILabel()
                rowLabel.text = "row: noWrap default (Can overflow)"
                flex.addItem(rowLabel)
                // example of row, with the UIViews next to each other
                flex.addItem().wrap(.noWrap).direction(.row).define { (flex) in
                    for i in 0...20 {
                        flex.addItem(items[i]).margin(10)
                    }
                }
            }

            flex.addItem().direction(.column).define{ (flex) in
            let rowWrapLabel = UILabel()
            rowWrapLabel.text = "row: wrap"
            flex.addItem(rowWrapLabel)
                flex.addItem().wrap(.wrap).direction(.row).define { (flex) in
                    for i in 21...40 {
                        flex.addItem(items[i]).margin(10)
                    }
                }

            }


            flex.addItem().direction(.column).marginTop(10).define{ (flex) in
                let rowWrapReverseLabel = UILabel()
                rowWrapReverseLabel.text = "row: wrap reverse"
                flex.addItem(rowWrapReverseLabel).grow(1)

                flex.addItem().wrap(.wrapReverse).direction(.row).define { (flex) in
                    for i in 41...60 {
                        flex.addItem(items[i]).margin(10)
                    }
                }
            }

            
            flex.addItem().direction(.column).height(200).define{ (flex) in
                let columnLabel = UILabel()
                columnLabel.text = "column: no wrap default (Can overflow)"
                flex.addItem(columnLabel)
                
                flex.addItem().wrap(.noWrap).direction(.column).define { (flex) in
                    for i in 61...70 {
                        flex.addItem(items[i]).margin(10).maxWidth(items[0].frame.width).maxHeight(items[0].frame.height).aspectRatio(1)
                    }
                }
            }

            flex.addItem().direction(.column).top(300).define{ (flex) in
                let columnWrapLabel = UILabel()
                columnWrapLabel.text = "column: wrap"
                flex.addItem(columnWrapLabel)
                flex.wrap(.wrap).direction(.column).grow(1).define { (flex) in
                    for i in 71...86 {
                        flex.addItem(items[i]).margin(10).maxWidth(items[0].frame.width).maxHeight(items[0].frame.height).aspectRatio(1)
                    }
                }
            }
            
            
            flex.addItem().direction(.column).top(10).define{ (flex) in
                let columnWrapLabel = UILabel()
                columnWrapLabel.text = "column: wrap reverse"
                flex.addItem(columnWrapLabel)
                flex.wrap(.wrapReverse).direction(.column).grow(1).define { (flex) in
                    for i in 100...105 {
                        flex.addItem(items[i]).margin(10).maxWidth(items[0].frame.width).maxHeight(items[0].frame.height).aspectRatio(1)
                    }
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
