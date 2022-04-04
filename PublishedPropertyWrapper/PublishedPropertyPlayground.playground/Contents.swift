import UIKit

// ObservableObject so objectWillChange is synthesized
// Meaning an ObservableObject is
// A type of object with a publisher that emits before the object has changed.
class Device: ObservableObject {
//    @Published var major: Int = 1
    
    var major: Int = 1
    {
        willSet {
            objectWillChange.send()
        }
    }
    var minor: Int = 0
    var patch: Int = 0
    
    func updateToNewVersion() {
        major += 1
        minor = 0
        patch = 0
    }
}

let tablet = Device()
print ("version: \(tablet.major).\(tablet.minor).\(tablet.patch)")

let cancellable = tablet.objectWillChange
    .sink { _ in
        print ("\(tablet.major).\(tablet.minor).\(tablet.patch) willChange")
}

tablet.updateToNewVersion()


