//
//  UIPageControllerWithAnimationTests.swift
//  UIPageControllerWithAnimationTests
//
//  Created by Steven Curtis on 27/05/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import XCTest
@testable import UIPageControllerWithAnimation

class UIPageControllerWithAnimationTests: XCTestCase {

    func testMod() {
        let p = PageViewController()
        XCTAssertEqual(p.mod(-1, 1),0)
    }
    
    func testModNeg() {
        let p = PageViewController()
        XCTAssertEqual(p.mod(2, 1),0)
    }
    
    func testOne() {
        var orderedViewControllers = [UIViewController]()
        if let experiment = UIStoryboard(name : "Main" , bundle : nil).instantiateViewController(withIdentifier: "PagesContent") as? InstructionsViewController {
            experiment.setupVC(title: "Experiment", mainText: "In this App you must say the color of a word but not the name of the word. \nFor accuracy enable the microphone on the next screen.", imageName: "phone1", bgColor: color2, fgColor: color1)
            orderedViewControllers.append(experiment)
        }
        
        if let learn = UIStoryboard(name : "Main" , bundle : nil).instantiateViewController(withIdentifier: "PagesContent") as? InstructionsViewController {
            learn.setupVC(title: "Learn", mainText: "Use your device microphone to say the color displayed", imageName: "phone2", bgColor: color1, fgColor: color2)
            orderedViewControllers.append(learn)
            
        }
        if let fun = UIStoryboard(name : "Main" , bundle : nil).instantiateViewController(withIdentifier: "PagesContent") as? InstructionsViewController {
            fun.setupVC(title: "Fun", mainText: "This should be a fun exercise rather than seen as a test", imageName: "phone3", bgColor: color2, fgColor: color1)
            orderedViewControllers.append(fun)
        }
        
        if let exit = UIStoryboard(name : "Main" , bundle : nil).instantiateViewController(withIdentifier: "PagesContent") as? InstructionsViewController {
            exit.setupVC(title: "OK", mainText: "Get ready to start!", imageName: "phone4", bgColor: color1, fgColor: color2)
            orderedViewControllers.append(exit)
        }
        
        let sv = UIScrollViewMock()
        let p = PageViewController(scrollview: sv, viewControllers: orderedViewControllers)
        sv.frame = CGRect(x: 0, y: 0, width: 414, height: 896)
        sv.contentSize = CGSize(width: 1242, height: 896)
        sv.contentOffset = CGPoint(x: 422.5, y: 0)
        p.setVarsForScroll()
        p.scrollViewDidScroll(sv)
        let fcv = p.orderedViewControllers[0] as! InstructionsViewController
        XCTAssertEqual(fcv.imageView!.frame,CGRect(x: 28.130434782608745, y: 56.76086956521743, width: 357.7391304347825, height: 561.478260869565))
    }
}
