//
//  AlignContentViewController.swift
//  YogakitGuide
//
//  Created by Steven Curtis on 13/07/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class AlignContentViewController: UIViewController {

    fileprivate let scrollView = UIScrollView()
    fileprivate let rootFlexContainer = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        var items: [UIView] = []
        var colours: [UIColor] = [UIColor.blue,UIColor.brown, UIColor.green, UIColor.red, UIColor.purple]
        
        let itemsInSection = 3
        
        
        for i in 0...300 {
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
        
        rootFlexContainer.flex.direction(.column).padding(100).define { (flex) in


        flex.addItem().direction(.column).define{ (flex) in
            let rowWrapLabel = UILabel()
            rowWrapLabel.numberOfLines = 0
            rowWrapLabel.text = "row: start alignContent (default)"
            flex.addItem(rowWrapLabel)
            flex.addItem().wrap(.wrap).direction(.row).height(200).define { (flex) in
                for i in 0...19 {
                    flex.addItem(items[i]).margin(10)
                }
            }
        }

        flex.addItem().direction(.column).define{ (flex) in
            let rowWrapLabel = UILabel()
            rowWrapLabel.numberOfLines = 0
            rowWrapLabel.text = "row: end alignContent"
            flex.addItem(rowWrapLabel)
            flex.addItem().wrap(.wrap).direction(.row).alignContent(.end).height(200).define { (flex) in
                for i in 20...39 {
                    flex.addItem(items[i]).margin(10)
                }
            }
        }


        flex.addItem().direction(.column).define{ (flex) in
            let rowWrapLabel = UILabel()
            rowWrapLabel.numberOfLines = 0
            rowWrapLabel.text = "row: center alignContent"
            flex.addItem(rowWrapLabel)
            flex.addItem().wrap(.wrap).direction(.row).alignContent(.center).height(200).define { (flex) in
                for i in 40...59 {
                    flex.addItem(items[i]).margin(10)
                }
            }
        }


        flex.addItem().direction(.column).define{ (flex) in
            let rowWrapLabel = UILabel()
            rowWrapLabel.numberOfLines = 0
            rowWrapLabel.text = "row: stretch alignContent"
            flex.addItem(rowWrapLabel)
            flex.addItem().wrap(.wrap).direction(.row).alignContent(.stretch).height(200).define { (flex) in
                for i in 60...79 {
                    flex.addItem(items[i]).margin(10)
                }
            }
        }


        flex.addItem().direction(.column).define{ (flex) in
            let rowWrapLabel = UILabel()
            rowWrapLabel.numberOfLines = 0
            rowWrapLabel.text = "row: spaceBetween alignContent"
            flex.addItem(rowWrapLabel)
            flex.addItem().wrap(.wrap).direction(.row).alignContent(.spaceBetween).height(200).define { (flex) in
                for i in 80...99 {
                    flex.addItem(items[i]).margin(10)
                }
            }
        }

        flex.addItem().direction(.column).define{ (flex) in
            let rowWrapLabel = UILabel()
            rowWrapLabel.numberOfLines = 0
            rowWrapLabel.text = "row: spaceAround alignContent"
            flex.addItem(rowWrapLabel)
            flex.addItem().wrap(.wrap).direction(.row).alignContent(.spaceAround).height(200).define { (flex) in
                for i in 100...119 {
                    flex.addItem(items[i]).margin(10)
                }
            }
        }

        // -------------- column --------------

        flex.addItem().direction(.column).define{ (flex) in
            let rowWrapLabel = UILabel()
            rowWrapLabel.numberOfLines = 0
            rowWrapLabel.text = "column: spaceAround alignContent"
            flex.addItem(rowWrapLabel)
            flex.addItem().wrap(.wrap).direction(.column).height(200).define { (flex) in
                for i in 120...139 {
                    flex.addItem(items[i]).margin(10)
                }
            }
        }

        flex.addItem().direction(.column).define{ (flex) in
            let rowWrapLabel = UILabel()
            rowWrapLabel.numberOfLines = 0
            rowWrapLabel.text = "column: end alignContent"
            flex.addItem(rowWrapLabel)
            flex.addItem().wrap(.wrap).direction(.column).alignContent(.end).height(200).define { (flex) in
                for i in 140...159 {
                    flex.addItem(items[i]).margin(10)
                }
            }
        }


        flex.addItem().direction(.column).define{ (flex) in
            let rowWrapLabel = UILabel()
            rowWrapLabel.numberOfLines = 0
            rowWrapLabel.text = "column: center alignContent"
            flex.addItem(rowWrapLabel)
            flex.addItem().wrap(.wrap).direction(.column).alignContent(.center).height(200).define { (flex) in
                for i in 160...179 {
                    flex.addItem(items[i]).margin(10)
                }
            }
        }


        flex.addItem().direction(.column).define{ (flex) in
            let rowWrapLabel = UILabel()
            rowWrapLabel.numberOfLines = 0
            rowWrapLabel.text = "column: stretch alignContent"
            flex.addItem(rowWrapLabel)
            flex.addItem().wrap(.wrap).direction(.column).alignContent(.stretch).height(200).define { (flex) in
                for i in 180...199 {
                    flex.addItem(items[i]).margin(10)
                }
            }
        }


        flex.addItem().direction(.column).define{ (flex) in
            let rowWrapLabel = UILabel()
            rowWrapLabel.numberOfLines = 0
            rowWrapLabel.text = "column: spaceBetween alignContent"
            flex.addItem(rowWrapLabel)
            flex.addItem().wrap(.wrap).direction(.column).alignContent(.spaceBetween).height(200).define { (flex) in
                for i in 200...219 {
                    flex.addItem(items[i]).margin(10)
                }
            }
        }

        flex.addItem().direction(.column).define{ (flex) in
            let rowWrapLabel = UILabel()
            rowWrapLabel.numberOfLines = 0
            rowWrapLabel.text = "column: spaceAround alignContent"
            flex.addItem(rowWrapLabel)
            flex.addItem().wrap(.wrap).direction(.column).alignContent(.spaceAround).height(200).define { (flex) in
                for i in 220...239 {
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
