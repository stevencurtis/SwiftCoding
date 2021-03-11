//
//  ExampleFrameworkSecondFile.swift
//  ExampleFramework
//
//  Created by Steven Curtis on 04/04/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation


class MyFrameworkInternalOtherFileSubClass: ModuleInternalClass {
    override var property: String {
        return "subclass"
    }
    
    // overrides an open func
    override func moduleclassfunc() {
        print ("MyFrameworkInternalSubClass")
    }
}


// no access
//class MyFrameworkFilePrivateOtherFileSubClass: ModuleFilePrivateClass {
//    override var property: String {
//        return "subclass"
//    }
//
//    // overrides an open func
//    override func moduleclassfunc() {
//        print ("MyFrameworkFilePrivateOtherFileSubClass")
//    }
//}

public class RunStuffInSecondFileInFramework{
    public func runIt() {
        ModuleInternalClass().moduleclassfunc()
        // ModuleFilePrivateClass().moduleclassfunc()
    }
    public init() {}
}
