import UIKit

class Holder<T>{
    var element: T
    init(_ element: T) {
        self.element = element
    }
    
}

let intHolder = Holder<Int>(1)

class CleverHolder<T>: Holder<T> {
    func amIHoldingANumber() -> Bool{
        return (type(of: element) == Int.self)
    }
    
    
}

let arrHolder = CleverHolder<Character>("A")
arrHolder.amIHoldingANumber()
