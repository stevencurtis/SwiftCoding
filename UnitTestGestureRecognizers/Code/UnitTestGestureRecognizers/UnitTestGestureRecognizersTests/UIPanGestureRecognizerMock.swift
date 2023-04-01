//
//  UIPanGestureRecognizerMock.swift
//  UnitTestGestureRecognizersTests
//
//  Created by Steven Curtis on 18/05/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit
@testable import UnitTestGestureRecognizers

class UIPanGestureRecognizerMock: NSObject, GestureRecognizerProtocol {
    var view: UIView?
    
    var delegate: UIGestureRecognizerDelegate?
    
    private let target: Any?
    private let action: Selector?
    var gestureState: UIGestureRecognizer.State?
    var gestureLocation: CGPoint?
    var gestureTranslation: CGPoint?
    var gestureVelocity: CGPoint?
    
    required init(target: Any?, action: Selector?) {
        self.target = target
        self.action = action
        view = UIView()
    }
    
    func mockTouch(
        location: CGPoint?,
        translation: CGPoint?,
        state: UIGestureRecognizer.State,
        completion: (Any?, Selector?)->()) {
        guard let action = action else {return}
        // do not need to actually produce the action here
        //        (test).perform!{
        //            print ("B")
        //        }
        (target! as! NSObject).perform(action, on: .current, with: nil, waitUntilDone: true)
        //        (target! as AnyObject).perform(action, on: .current, with: self, waitUntilDone: true)
        completion(target, action)
    }
    
    //    func translation(in view: UIView?) -> CGPoint {
    //        return CGPoint(x: 0, y: 0)
    //    }
    
}
