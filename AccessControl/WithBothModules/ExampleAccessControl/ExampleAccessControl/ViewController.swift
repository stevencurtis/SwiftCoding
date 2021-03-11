//
//  ViewController.swift
//  ExampleAccessControl
//
//  Created by Steven Curtis on 03/04/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit
import ExampleFramework

// subclass of class in framework - can subclass if open
class MyOpenSubClass: ModuleOpenClass {
    override var property: String {
        return "subclass"
    }

    // overrides an open func
    override func moduleclassfunc() {
        print ("subclass do stuff")
    }
}

// Cannot inherit from non-open class - so this applies for public and all other Access Control types
//class MyPublicSubClass: ModulePublicClass {
//    //Overriding non-open property outside of its defining module
//    override var property: String {
//        return "subclass"
//    }
//
//    // Overriding non-open instance method outside of its defining module
//    override func moduleclassfunc() {
//        print ("subclass do stuff")
//    }
//}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print (MyOpenSubClass().property)
        MyOpenSubClass().moduleclassfunc()
        
        print (ModuleOpenClass().property)
        ModuleOpenClass().moduleclassfunc()
        
        
        // functions the same as open here
        print (ModulePublicClass().property)
        ModulePublicClass().moduleclassfunc()


        // Cannot access anything else
//        print (ModuleInternalClass())
        // print (ModuleFilePrivateClass())
        
        RunStuffInFramework().runIt()
    }


}

