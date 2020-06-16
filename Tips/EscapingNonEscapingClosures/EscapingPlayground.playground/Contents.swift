import UIKit

class nonescapingClosure {
    let add: (Int,Int) -> () = { a,b in
        print("Result \(a + b)")
    }
    func mathForOneAndTwo(firstNum: Int, secondNum: Int, action: (Int,Int) -> Void) {
        action(firstNum,secondNum)
    }
}
nonescapingClosure().mathForOneAndTwo(firstNum: 1, secondNum: 2, action: nonescapingClosure().add)


class escapingClosure {
    let add: (Int,Int) -> () = { a, b in
        print("Result \(a + b)")
    }
    func mathForOneAndTwo(firstNum: Int, secondNum: Int, action: @escaping (Int,Int) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            action(firstNum,secondNum)
        } )
    }
}
escapingClosure().mathForOneAndTwo(firstNum: 1, secondNum: 2, action: escapingClosure().add)


