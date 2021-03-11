//
//  subclassedView.swift
//  hitTestPointInside
//
//  Created by Steven Curtis on 12/11/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit

class SubclassedView: UIView {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    func configure() {
        isUserInteractionEnabled = true
        let dragGesture = UIPanGestureRecognizer(target: self, action: #selector(dragging(gesture:)))
        addGestureRecognizer(dragGesture)
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
    
    var lastLocation = CGPoint(x: 0, y: 0)

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastLocation = self.center
    }
    
    @objc func dragging(gesture: UIPanGestureRecognizer) {
        let translation  = gesture.translation(in: self.parentView)
        self.center = CGPoint(x: lastLocation.x + translation.x, y: lastLocation.y + translation.y)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let frame = self.bounds.insetBy(dx: -20, dy: -20)
        return frame.contains(point) ? self : nil
    }
//        print (point, super.hitTest(point, with: event), self.tag)
//        print ("hittest", self.tag, super.hitTest(point, with: event)?.tag )
//        let hitTestView = super.hitTest(point, with: event)
//        if  hitTestView == self {return nil}
//        return super.hitTest(point, with: event)
//    }
    
//    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
//        let frame = self.bounds.insetBy(dx: -20, dy: -20)
//        return frame.contains(point) ? true : false
        
//        let superBool = super.point(inside: point, with: event)
//        print ("point", point, event, superBool)
//        return superBool
//    }
    
    
    
}
