import UIKit

//  Lazy provides eferred property initialization
struct People {
    lazy var names = ["Saanvi"]
}

// _ prefix is the Objective-C way to indicate a backing store
// _names
struct People {
        private var _names: [String]?
        var names: [String] {
            mutating get {
                // this returns the backing store, iff populated
                if let initNames = _names { return initNames }
                // populate the backing store, only if it has not previously
                // been populated
                let initialValue = ["Saanvi"]
                _names = initialValue
                return initialValue
            }

            set {
                // set initialises the backing store
                _names = newValue
            }
        }
}

var people = People()
print (people.names)
print (people.names)
