import UIKit
import XCTest

// The typical Singleton Pattern
// Used as
// URLSession.shared

// https://developer.apple.com/documentation/swift/cocoa_design_patterns/managing_a_shared_resource_using_a_singleton

//class Singleton {
//    static let sharedInstance = Singleton()
//}


class Singleton {
    var localCounter = 1
    static let shared: Singleton = {
        let instance = Singleton()
        // setup code
        return instance
    }()
    
    private init() {}
    
    func incCounter() {
        self.localCounter += 1
    }
    
    func currentCounter() -> Int {
        return localCounter
    }
}

var mySingleton = Singleton.shared
mySingleton.incCounter()
var mySecondSingleton = Singleton.shared
mySingleton.incCounter()
mySecondSingleton.incCounter()
print (mySingleton.currentCounter())




