import UIKit


struct Ref<T> {
    var val : T
    init(_ v : T) {val = v}
}

struct Box<T> {
    var ref : Ref<T>
    init(_ x : T) { ref = Ref(x) }
    
    var value: T {
        get { return ref.val }
        set {
            if (!isKnownUniquelyReferenced(ref)) {
                ref = Ref(newValue)
                return
            }
            ref.val = newValue
        }
    }
}
// This code was an example taken from the swift repo doc file OptimizationTips
// Link: https://github.com/apple/swift/blob/master/docs/OptimizationTips.rst#advice-use-copy-on-write-semantics-for-large-values

