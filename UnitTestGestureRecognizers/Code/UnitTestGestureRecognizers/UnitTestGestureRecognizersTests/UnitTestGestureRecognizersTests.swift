//
//  UnitTestGestureRecognizersTests.swift
//  UnitTestGestureRecognizersTests
//
//  Created by Steven Curtis on 18/05/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import XCTest
@testable import UnitTestGestureRecognizers

class UnitTestGestureRecognizersTests: XCTestCase {
    @objc func standardHandlePan(_ sender: UIPanGestureRecognizer) {
        print ("standardHandlePan")
    }
    
    // GestureRecognizerMock with actual View, test panHandler
    func testTouch() {
        let view = PanRotatePinchUIView()
        let mockedPanGesture = UIPanGestureRecognizerMock(
            target: self,
            action: #selector(standardHandlePan(_:)))
        view.panGestureRecognizer = mockedPanGesture
        mockedPanGesture.mockTouch(
            location:
            CGPoint(x: 0, y: 0),
            translation: CGPoint(x: 0, y: 0),
            state: .began,
            completion:
            {target, selector in
                XCTAssertEqual( (target as! UnitTestGestureRecognizersTests), self)
                XCTAssertEqual( selector, #selector(standardHandlePan(_:)) )
        })
    }
    
    // GestureRecognizerMock with actual View, actual panHandler. Within PanRotatePinchUIView this fails at the point inside standardHandlePan as we are passing a mock and not a real gesture class
    func testPan() {
        let view = PanRotatePinchUIView()
        let mockedPanGesture = UIPanGestureRecognizerMock(
            target: view,
            action: #selector(standardHandlePan(_:))
        )
        view.panGestureRecognizer = mockedPanGesture
        mockedPanGesture.mockTouch(
            location: CGPoint(x: 0, y: 0),
            translation: CGPoint(x: 0, y: 0),
            state: .began,
            completion:
            {target, selector in
//                XCTAssertEqual( (target as! view), view)
                XCTAssertEqual( selector, #selector(standardHandlePan(_:)) )
        })
    }
    
    func testingPan() {
        let panGesterRecognizerMock =  UIPanGesturerecognizerSubClassMock()
        let target = panGesterRecognizerMock
        let selector = #selector(standardHandlePan(_:))
        
//        let passview =  UIPanGestureRecognizer(target: target, action: selector)
//        let view = PanRotatePinchUIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
//        view.addGestureRecognizer(passview)
//
//        let superview = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
//        superview.addSubview(view)

        // let pgr =  view.panGestureRecognizer as! UIPanGestureRecognizerMock
        panGesterRecognizerMock.mockTouch(location: CGPoint(x: 50, y: 50), translation: CGPoint(x: 100, y: 100), state: .ended, target: target, action: selector, gestureRecognizer: panGesterRecognizerMock, completion:
            {target, selector in
                print( panGesterRecognizerMock.frame)
                XCTAssertEqual( selector, #selector(standardHandlePan(_:)) )
        })
    }
}

class UIPanGesturerecognizerSubClassMock: PanRotatePinchUIView {
    private var target: Any?
    private var action: Selector?
    private var view: UIView?
    func mockTouch(
        location: CGPoint?,
        translation: CGPoint?,
        state: UIGestureRecognizer.State,
        target: Any,
        action: Selector,
        gestureRecognizer: UIPanGesturerecognizerSubClassMock,
        completion: (Any?, Selector?)->()) {
        
//        var testgest = UIPanGestureRecognizer(target: target, action: action)
//        let test = UIView()
//        test.addGestureRecognizer(testgest)
        
        (target as! NSObject).perform(action, on: .current, with: gestureRecognizer, waitUntilDone: true)
        completion(target, action)
    }
    // must use the real gesture recognizer
//    override func setup() {
//        target = self
//        action = #selector(standardHandlePan(_:))
//         panGestureRecognizer = UIPanGestureRecognizerMock(
//             target: self,
//             action: #selector(standardHandlePan(_:))
//         )
//    }
    

    
}
