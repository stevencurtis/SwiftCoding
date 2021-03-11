//
//  ExampleFramwork.swift
//  ExampleFramework
//
//  Created by Steven Curtis on 03/04/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation

open class ModuleOpenClass {
    open var property : String {
        return "Superclass"
    }
    
    open func moduleclassfunc() {
        print ("ModuleOpenClass")
    }
    
    // init needs to be public
    public init() {}
}

class MyFrameworkOpenSubClass: ModuleOpenClass {
    override var property: String {
        return "subclass"
    }
    
    // overrides an open func
    override func moduleclassfunc() {
        print ("subclass do stuff")
    }
}


public class ModulePublicClass {
    public var property : String {
        return "Superclass"
    }

    public func moduleclassfunc() {
        print ("ModulePublicClass")
    }

    public init() {}
}

class MyFrameworkPublicSubClass: ModulePublicClass {
    override var property: String {
        return "subclass"
    }
    
    // overrides an open func
    override func moduleclassfunc() {
        print ("ModuleFilePrivateClass")
    }
}


internal class ModuleInternalClass {
    internal var property : String {
        return "Superclass"
    }

    internal func moduleclassfunc() {
        print ("ModuleInternalClass")
    }

    public init() {}
}

class MyFrameworkInternalSubClass: ModuleInternalClass {
    override var property: String {
        return "subclass"
    }
    
    // overrides an open func
    override func moduleclassfunc() {
        print ("MyFrameworkInternalSubClass")
    }
}



fileprivate class MyFrameworkFilePrivateSubClass: ModuleFilePrivateClass {
    override var property: String {
        return "subclass"
    }
    
    // overrides an open func
    override func moduleclassfunc() {
        print ("MyFrameworkInternalSubClass")
    }
}

class MyInternalSubClass: ModuleInternalClass {
    override var property: String {
        return "subclass"
    }

    // overrides an open func
    override func moduleclassfunc() {
        print ("ModuleFilePrivateClass")
    }
}

fileprivate class ModuleFilePrivateClass {
    fileprivate var property : String {
        return "Superclass"
    }
    
    fileprivate func moduleclassfunc() {
        print ("ModuleFilePrivateClass")
    }
    
    public init() {}
}

fileprivate class MyFilePrivateSubClass: ModuleFilePrivateClass {
    override var property: String {
        return "subclass"
    }
    
    // overrides an open func
    override func moduleclassfunc() {
        print ("ModuleFilePrivateClass")
    }
}



private class ModulePrivateClass {
    private var property : String {
        return "Superclass"
    }
    
    private func moduleclassfunc() {
        print ("ModuleFilePrivateClass")
    }
    
    public init() {}
}


//private class MyPrivateSubClass: ModulePrivateClass {
//    // can only access if the property is fileprivate, or a less restrictive access
//    override var property: String {
//        return "subclass"
//    }
//
//    // overrides an open func
//    override func moduleclassfunc() {
//        print ("ModuleFilePrivateClass")
//    }
//}


public class ModuleMixedClass {
    private var property : String {
        return "Superclass"
    }
    
    public func returnproperty() -> String {
        return property
    }
    
    public init() {}
}


public class RunStuffInFramework{
    public func runIt() {
        print ("RunStuffInFramework")
        ModuleOpenClass().moduleclassfunc()
//        ModuleFilePrivateClass().moduleclassfunc()
//         ModulePrivateClass().moduleclassfunc()
        ModuleInternalClass().moduleclassfunc()
        
        print ("AA", ModuleMixedClass().returnproperty())
        
    }
    public init() {}
    
}

