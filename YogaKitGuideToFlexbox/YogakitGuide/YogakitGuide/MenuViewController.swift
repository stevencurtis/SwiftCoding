//
//  MenuViewController.swift
//  YogakitGuide
//
//  Created by Steven Curtis on 11/07/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit
import FlexLayout

class MenuViewController: UIViewController {
    
    fileprivate let rootFlexContainer = UIView()

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rootFlexContainer.flex.layout(mode: .fitContainer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .red
        
        let label = UILabel()
        label.text = "Flexbox layouts are simple, powerful and fast.\n\nFlexLayout syntax is concise and chainable."
        label.numberOfLines = 0
        
        let defineBtn = UIButton(type: .roundedRect)
        defineBtn.setTitle("Define", for: .normal)
        defineBtn.addTarget(self, action: #selector(defineExample), for: .touchUpInside)
        
        let defineBtnRotation = UIButton(type: .roundedRect)
        defineBtnRotation.setTitle("Define with rotation", for: .normal)
        defineBtnRotation.addTarget(self, action: #selector(defineExampleRotation), for: .touchUpInside)
        
        let directionBtn = UIButton(type: .roundedRect)
        directionBtn.setTitle("Direction examples", for: .normal)
        directionBtn.addTarget(self, action: #selector(directionExamples), for: .touchUpInside)
        
        let wrapBtn = UIButton(type: .roundedRect)
        wrapBtn.setTitle("Wrap examples", for: .normal)
        wrapBtn.addTarget(self, action: #selector(wrapExamples), for: .touchUpInside)
        
        let justifyBtn = UIButton(type: .roundedRect)
        justifyBtn.setTitle("Justification examples", for: .normal)
        justifyBtn.addTarget(self, action: #selector(justifyExamples), for: .touchUpInside)
        
        let alignItemsBtn = UIButton(type: .roundedRect)
        alignItemsBtn.setTitle("alignItems examples", for: .normal)
        alignItemsBtn.addTarget(self, action: #selector(alignItemsExamples), for: .touchUpInside)
        
        let alignContentBtn = UIButton(type: .roundedRect)
        alignContentBtn.setTitle("alignContent examples", for: .normal)
        alignContentBtn.addTarget(self, action: #selector(alignContentExamples), for: .touchUpInside)
        
        let growBtn = UIButton(type: .roundedRect)
        growBtn.setTitle("grow examples", for: .normal)
        growBtn.addTarget(self, action: #selector(growExamples), for: .touchUpInside)

        let shrinkBtn = UIButton(type: .roundedRect)
        shrinkBtn.setTitle("shrink examples", for: .normal)
        shrinkBtn.addTarget(self, action: #selector(shrinkExamples), for: .touchUpInside)

        let basisBtn = UIButton(type: .roundedRect)
        basisBtn.setTitle("basis examples", for: .normal)
        basisBtn.addTarget(self, action: #selector(basisExamples), for: .touchUpInside)
        
        let alignBtn = UIButton(type: .roundedRect)
        alignBtn.setTitle("align button examples", for: .normal)
        alignBtn.addTarget(self, action: #selector(alignExamples), for: .touchUpInside)
        
        rootFlexContainer.flex.direction(.column).padding(12).define { (flex) in
            // Row container
            flex.addItem().direction(.row).define { (flex) in
                // Column container
                flex.addItem().direction(.column).paddingLeft(12).grow(1).shrink(1).define { (flex) in
                    flex.addItem(label)
                }
            }
            flex.addItem().height(1).marginTop(12).backgroundColor(.lightGray)
            flex.addItem(defineBtn)
            flex.addItem(defineBtnRotation)
            flex.addItem(directionBtn)
            flex.addItem(wrapBtn)
            flex.addItem(justifyBtn)
            flex.addItem(alignItemsBtn)
            flex.addItem(alignContentBtn)
            flex.addItem(growBtn)
            flex.addItem(shrinkBtn)
            flex.addItem(basisBtn)
            flex.addItem(alignBtn)
        }
        
        self.view.addSubview(rootFlexContainer)
        
        rootFlexContainer.translatesAutoresizingMaskIntoConstraints = false
        rootFlexContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        rootFlexContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        rootFlexContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        rootFlexContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc func defineExample() {
        self.navigationController?.pushViewController(DefineExampleViewController(), animated: true)
    }
    
    @objc func defineExampleRotation() {
        self.navigationController?.pushViewController(DefineExampleRotationViewController(), animated: true)
    }

    @objc func directionExamples() {
        self.navigationController?.pushViewController(DirectionViewController(), animated: true)
    }

    @objc func wrapExamples() {
        self.navigationController?.pushViewController(WrapViewController(), animated: true)
    }
    
    @objc func justifyExamples() {
        self.navigationController?.pushViewController(JustificationContentViewController(), animated: true)
    }
    
    @objc func alignItemsExamples() {
        self.navigationController?.pushViewController(AlignItemsViewController(), animated: true)
    }
    
    @objc func alignContentExamples() {
        self.navigationController?.pushViewController(AlignContentViewController(), animated: true)
    }
    
    @objc func growExamples() {
        self.navigationController?.pushViewController(GrowViewController(), animated: true)
    }
    
    @objc func shrinkExamples() {
        self.navigationController?.pushViewController(ShrinkViewController(), animated: true)
    }
    
    @objc func basisExamples() {
        self.navigationController?.pushViewController(BasisViewController(), animated: true)
    }
    
    @objc func alignExamples() {
        self.navigationController?.pushViewController(AlignSelfViewController(), animated: true)
    }
    
}
