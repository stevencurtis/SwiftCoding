//
//  PanRotatePinchUIView.swift
//  ImageZoomView
//
//  Created by Steven Curtis on 18/05/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

protocol GestureRecognizerProtocol {
    init(target: Any?, action: Selector?)
}

extension UIPanGestureRecognizer: GestureRecognizerProtocol {}

class PanRotatePinchUIView: UIView, UIGestureRecognizerDelegate {
    func test() {
        let gest = UIPanGestureRecognizer()
        gest.translation(in: self)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    var panGestureRecognizer: GestureRecognizerProtocol!
    
    // will be overidden in the mock
    func setup() {
        panGestureRecognizer = UIPanGestureRecognizer(
            target: self,
            action: #selector(standardHandlePan(_:)))
        self.addGestureRecognizer(panGestureRecognizer as! UIGestureRecognizer)
    }

    // this can only handle "real" Pan gestures
    @objc func standardHandlePan(_ sender: UIPanGestureRecognizer) {
        guard let targetView = sender.view else {return}
        
        let translation = sender.translation(in: self.superview)
        targetView.center = CGPoint(x: targetView.center.x + translation.x
            ,y: targetView.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.superview)
    }
    
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer)
        -> Bool {
            return true
    }
}
