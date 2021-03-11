//
//  JustifyContentViewController.swift
//  YogakitGuide
//
//  Created by Steven Curtis on 13/07/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class JustificationContentViewController: UIViewController {
    
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
                rowLabel.text = "Start (default) justification on a row"
                flex.addItem(rowLabel)
                // example of row, with the UIViews next to each other
                flex.addItem().direction(.row).justifyContent(.start).define { (flex) in
                    for i in 0...4 {
                        flex.addItem(items[i]).margin(10)
                    }
                }
            }
            
            flex.addItem().direction(.column).define{ (flex) in
                let rowLabel = UILabel()
                rowLabel.text = "end justification on a row"
                flex.addItem(rowLabel)
                // example of row, with the UIViews next to each other
                flex.addItem().direction(.row).justifyContent(.end).define { (flex) in
                    for i in 5...9 {
                        flex.addItem(items[i]).margin(10)
                    }
                }
            }
            
            flex.addItem().direction(.column).define{ (flex) in
                let rowLabel = UILabel()
                rowLabel.text = "center justification on a row"
                flex.addItem(rowLabel)
                // example of row, with the UIViews next to each other
                flex.addItem().direction(.row).justifyContent(.center).define { (flex) in
                    for i in 10...14 {
                        flex.addItem(items[i]).margin(10)
                    }
                }
            }
            
            flex.addItem().direction(.column).define{ (flex) in
                let rowLabel = UILabel()
                rowLabel.text = "spaceBetween justification on a row. Items are evenly distributed, the first item is on the start line and the last item on the end line."
                rowLabel.numberOfLines = 0
                flex.addItem(rowLabel)
                // example of row, with the UIViews next to each other
                flex.addItem().direction(.row).justifyContent(.spaceBetween).define { (flex) in
                    for i in 15...19 {
                        flex.addItem(items[i]).margin(10)
                    }
                }
            }
            
            flex.addItem().direction(.column).define{ (flex) in
                let rowLabel = UILabel()
                rowLabel.text = "spaceAround justification on a row. Items evenly distributed on the line with ecen space. The first item has one unit of space to the container edge, and two units of spaces to the next item."
                rowLabel.numberOfLines = 0
                flex.addItem(rowLabel)
                // example of row, with the UIViews next to each other
                flex.addItem().direction(.row).justifyContent(.spaceAround).define { (flex) in
                    for i in 20...24 {
                        flex.addItem(items[i]).margin(10)
                    }
                }
            }
            
            
            flex.addItem().direction(.column).define{ (flex) in
                let rowLabel = UILabel()
                rowLabel.text = "spaceEvenly justification on a row. So there is an equal spacing between any two items (and the edges)"
                rowLabel.numberOfLines = 0
                flex.addItem(rowLabel)
                // example of row, with the UIViews next to each other
                flex.addItem().direction(.row).justifyContent(.spaceEvenly).define { (flex) in
                    for i in 25...29 {
                        flex.addItem(items[i]).margin(10)
                    }
                }
            }
            
            flex.addItem().direction(.column).define{ (flex) in
                let rowLabel = UILabel()
                rowLabel.text = "Start (default) justification on a column"
                flex.addItem(rowLabel)
                // example of row, with the UIViews next to each other
                flex.addItem().direction(.column).height(200).justifyContent(.start).define { (flex) in
                    for i in 30...32 {
                        flex.addItem(items[i]).margin(10).maxHeight(items[0].frame.height).maxWidth(items[0].frame.width)
                    }
                }
            }
            
            
            flex.addItem().direction(.column).define{ (flex) in
                let rowLabel = UILabel()
                rowLabel.text = "end justification on a column"
                flex.addItem(rowLabel)
                // example of row, with the UIViews next to each other
                flex.addItem().direction(.column).height(200).justifyContent(.end).define { (flex) in
                    for i in 33...35 {
                        flex.addItem(items[i]).margin(10).maxHeight(items[0].frame.height).maxWidth(items[0].frame.width)
                    }
                }
            }
            
            
            
            flex.addItem().direction(.column).define{ (flex) in
                let rowLabel = UILabel()
                rowLabel.text = "center justification on a column"
                flex.addItem(rowLabel)
                // example of row, with the UIViews next to each other
                flex.addItem().direction(.column).height(200).justifyContent(.center).define { (flex) in
                    for i in 36...38 {
                        flex.addItem(items[i]).margin(10).maxHeight(items[0].frame.height).maxWidth(items[0].frame.width)
                    }
                }
            }
            
            
            flex.addItem().direction(.column).define{ (flex) in
                let rowLabel = UILabel()
                rowLabel.text = "spaceBetween justification on a column. Items are evenly distributed, the first item is on the start line and the last item on the end line."
                flex.addItem(rowLabel)
                // example of row, with the UIViews next to each other
                flex.addItem().direction(.column).height(200).justifyContent(.spaceBetween).define { (flex) in
                    for i in 39...41 {
                        flex.addItem(items[i]).margin(10).maxHeight(items[0].frame.height).maxWidth(items[0].frame.width)
                    }
                }
            }
            
            
            
            flex.addItem().direction(.column).define{ (flex) in
                let rowLabel = UILabel()
                rowLabel.text = "spaceAround justification on a column. Items evenly distributed on the line with ecen space. The first item has one unit of space to the container edge, and two units of spaces to the next item."
                flex.addItem(rowLabel)
                // example of row, with the UIViews next to each other
                flex.addItem().direction(.column).height(200).justifyContent(.spaceAround).define { (flex) in
                    for i in 42...44 {
                        flex.addItem(items[i]).margin(10).maxHeight(items[0].frame.height).maxWidth(items[0].frame.width)
                    }
                }
            }
            
            
            
            
            flex.addItem().direction(.column).define{ (flex) in
                let rowLabel = UILabel()
                rowLabel.text = "spaceEvenly justification on a column. So there is an equal spacing between any two items (and the edges)"
                flex.addItem(rowLabel)
                // example of row, with the UIViews next to each other
                flex.addItem().direction(.column).height(200).justifyContent(.spaceEvenly).define { (flex) in
                    for i in 44...46 {
                        flex.addItem(items[i]).margin(10).maxHeight(items[0].frame.height).maxWidth(items[0].frame.width)
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
