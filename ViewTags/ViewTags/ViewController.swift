//
//  ViewController.swift
//  ViewTags
//
//  Created by Steven Curtis on 26/09/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = UIView()
        view.tag = 0

        for subView in view.subviews {
            print(subView.tag)
        }
        
        print(ObjectIdentifier(view))
    }
}


extension UIView {

    var identifier: ObjectIdentifier? {
        set {
            if let value = newValue {
                self.tag = ObjectIdentifier(self).hashValue
            }
        }
        get {
            return ObjectIdentifier(self)
        }
    }

    func view(withId id: ViewIdentifier) -> UIView? {
        return self.viewWithTag(id.rawValue)
    }
}
