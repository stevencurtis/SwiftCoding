//
//  ViewController.swift
//  CopingWithLongParameterList
//
//  Created by Steven Curtis on 04/12/2020.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let viewWidth = self.view.frame.width
        let sizeRatio = ratio(width: viewWidth, size: .small)
        let easyRatio = ratio(size: .small)
        
        _ = averageHeight(lowValue: 1, highValue: 3, n: 3)
        _ = averageHeight(values: 1,2,3)
    }
    
    enum UserSize: Double {
        case small = 0.8
        case medium = 1.0
        case large = 1.2
    }
    
    func ratio(width: CGFloat, size: UserSize) -> CGFloat {
        return width * CGFloat(size.rawValue)
    }

    func ratio(size: UserSize) -> CGFloat {
        return self.view.frame.width * CGFloat(size.rawValue)
    }
    
    func averageHeight(lowValue: Double, highValue: Double, n: Int) -> Double{
        return highValue - lowValue / Double(n)
    }
    
    func averageHeight(values: Double...) -> Double {
        return values.max()! - values.min()! / Double(values.count)
    }
    
    
    func studentScore(name: String, age: Int, test: Int){
        print ("\(name): \(age) got \(test) out of 10")
    }
    
//    class Test {
//        let name: String
//        let age: Int
//        let test: Int
//
//        init (name: String, age: Int, test: Int) {
//            self.name = name
//            self.age = age
//            self.test = test
//        }
//    }
//
//    func studentScore(res: Test){
//        print ("\(res.name): \(res.age) got \(res.test) out of 10")
//    }
    
    struct Test {
        let testScore: Int
        let testSubject: String
        init (testSubject: String, testScore: Int) {
            self.testSubject = testSubject
            self.testScore = testScore
        }
    }
    
    struct Student {
        let name: String
        let age: Int
        init (name: String, age: Int) {
            self.name = name
            self.age = age
        }
    }
    
    func studentScore(test: Test, student: Student){
        print ("\(student.name): \(student.age) got \(test.testScore) out of 10")
    }
}

