//
//  SubclassedView.swift
//  hittest
//
//  Created by Steven Curtis on 26/11/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class SubclassedView: UIView {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    func configure() {
        isUserInteractionEnabled = true
        let dragGesture = UIPanGestureRecognizer(target: self, action: #selector(dragging(gesture:)))
        addGestureRecognizer(dragGesture)
    }
    
    var lastLocation = CGPoint(x: 0, y: 0)
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastLocation = self.center
    }
    
    @objc func dragging(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.parentView)
        self.center = CGPoint(x: lastLocation.x + translation.x, y: lastLocation.y + translation.y)
    }
    
    private var _parentView: UIView!
    
    var parentView: UIView {
        set {
            _parentView = newValue
        }
        get {
            return _parentView
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        print (point, super.hitTest(point, with: event)?.tag)
//        return super.hitTest(point, with: event)
        let frame = self.bounds.insetBy(dx: -20, dy: -20)
        return frame.contains(point) ? self : nil
    }
    
//    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
//        print (super.point(inside: point, with: event))
//        return super.point(inside: point, with: event)
//    }
    
}
