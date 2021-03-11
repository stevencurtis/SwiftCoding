//
//  AlignItemsViewController.swift
//  YogakitGuide
//
//  Created by Steven Curtis on 13/07/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class AlignItemsViewController: UIViewController {
    
    fileprivate let scrollView = UIScrollView()
    fileprivate let rootFlexContainer = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        var items: [UIView] = []
        var colours: [UIColor] = [UIColor.blue,UIColor.brown, UIColor.green, UIColor.red, UIColor.purple]
        
        let itemsInSection = 3
    
    
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
                rowLabel.text = "row: align items stretch (default). Respect min-width/ max-width"
                flex.addItem(rowLabel)
                // example of row, with the UIViews next to each other
                flex.addItem().direction(.row).height(200).define { (flex) in
                    for i in 0...itemsInSection - 1 {
                        flex.addItem(items[i]).margin(10)
                    }
                }
            }
            
            flex.addItem().direction(.column).define{ (flex) in
                let rowLabel = UILabel()
                rowLabel.text = "row: align items start. cross-start margin edge of the items is placed on the cross-start line."
                flex.addItem(rowLabel)
                // example of row, with the UIViews next to each other
                flex.addItem().direction(.row).height(200).alignItems(.start).define { (flex) in
                    for i in itemsInSection...itemsInSection * 2 - 1 {
                        flex.addItem(items[i]).margin(10)
                    }
                }
            }
            
            
            flex.addItem().direction(.column).define{ (flex) in
                let rowLabel = UILabel()
                rowLabel.text = "row: align items end. cross-start margin edge of the items is placed on the cross-start line."
                flex.addItem(rowLabel)
                // example of row, with the UIViews next to each other
                flex.addItem().direction(.row).height(200).alignItems(.end).define { (flex) in
                    for i in itemsInSection * 2...itemsInSection * 3 - 1 {
                        flex.addItem(items[i]).margin(10)
                    }
                }
            }
            
            
            flex.addItem().direction(.column).define{ (flex) in
                let rowLabel = UILabel()
                rowLabel.text = "row: align items center. items centered in the cross-axis."
                flex.addItem(rowLabel)
                // example of row, with the UIViews next to each other
                flex.addItem().direction(.row).height(200).alignItems(.center).define { (flex) in
                    for i in itemsInSection * 3...itemsInSection * 4 - 1 {
                        flex.addItem(items[i]).margin(10)
                    }
                }
            }
            
            // column ---------------
            
            flex.addItem().direction(.column).define{ (flex) in
                let rowLabel = UILabel()
                rowLabel.text = "column: align items stretch (default)"
                flex.addItem(rowLabel)
                // example of row, with the UIViews next to each other
                flex.addItem().direction(.column).height(200).define { (flex) in
                    for i in itemsInSection * 4...itemsInSection * 5 - 1 {
                        flex.addItem(items[i]).margin(10)
                    }
                }
            }
            
            flex.addItem().direction(.column).define{ (flex) in
                let rowLabel = UILabel()
                rowLabel.text = "column: align items start"
                flex.addItem(rowLabel)
                // example of row, with the UIViews next to each other
                flex.addItem().direction(.column).height(200).alignItems(.start).define { (flex) in
                    for i in itemsInSection * 5...itemsInSection * 6 - 1 {
                        flex.addItem(items[i]).margin(10)
                    }
                }
            }
            
            
            flex.addItem().direction(.column).define{ (flex) in
                let rowLabel = UILabel()
                rowLabel.text = "column: align items end"
                flex.addItem(rowLabel)
                // example of row, with the UIViews next to each other
                flex.addItem().direction(.column).height(200).alignItems(.end).define { (flex) in
                    for i in itemsInSection * 6...itemsInSection * 7 - 1 {
                        flex.addItem(items[i]).margin(10)
                    }
                }
            }
            
            
            flex.addItem().direction(.column).define{ (flex) in
                let rowLabel = UILabel()
                rowLabel.text = "column: align items center"
                flex.addItem(rowLabel)
                // example of row, with the UIViews next to each other
                flex.addItem().direction(.column).height(200).alignItems(.center).define { (flex) in
                    for i in itemsInSection * 8...itemsInSection * 9 - 1 {
                        flex.addItem(items[i]).margin(10)
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
