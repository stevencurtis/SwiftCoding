//
//  TestTF.swift
//  TwoWayBindingTests
//
//  Created by Steven Curtis on 06/11/2020.
//

import UIKit

class TestTF: UITextField {
    var closure: ((String) -> ())?
    override var text: String? {
         didSet {
            if let closure = closure {
                closure(text!)
            }
         }
     }
}
