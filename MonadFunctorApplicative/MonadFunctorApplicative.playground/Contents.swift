import UIKit

//let numberArr = [1,2,3,4,5]
//var numbers: [Int] = []
//for number in numberArr {
//    numbers.append(number * 2)
//}

// print(numbers)

extension Array {
    func mapped<U>(transform: (U) -> U) -> [U] {
        var array: [U] = []
        for x in self {
            let y = transform(x as! U)
            array.append(y)
        }
        return array
    }
}

let numbers = [1,2,3]
print(numbers.mapped{ $0 * 2 })

print(numbers.map{ $0 * 2 })
numbers.flatMap{ $0 }

print("A")

enum Optional<T> {
    case Some(T), Nil
    
    func map<U>(_ f: (T) -> U) -> U? {
        switch self {
        case .Some(let x): return f(x)
        case .Nil: return .none
        }
    }
}

func plusThree(number: Int) -> Int {
    return number + 3
}

print(Optional.Some(2).map(plusThree))
print(Optional.Nil.map(plusThree))

extension Optional {
    func apply<U>(f: ((T) -> U)?) -> U? {
        return f.flatMap { self.map($0) }
    }
}
