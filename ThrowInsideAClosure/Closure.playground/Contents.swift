import UIKit


/// Initial fake network call
//func incNum(num: Int,  completion: @escaping (Int) -> Void)  {
//    // "Network call"
//    completion(num + 1)
//}
//
//func callingFunction(num: Int, closure:  (Int, @escaping (Int) -> Void) -> Void ) {
//    closure(num, { result in
//        print (result)
//    })
//}
//
//callingFunction(num: 5, closure: incNum)


/// Introduce BadLuckError
//enum BadLuckError: Error {
//    case unlucky
//}
//
//func incNum(num: Int, completion: (Int) -> Void) {
//    // "Network call"
//    completion(num + 1)
//}
//
//func callingFunction(num: Int, closure: (Int, (Int) -> Void) -> Void ) {
//    closure(num, { result in
//        print (result)
//        if result == 13 {
//            throw BadLuckError.unlucky
//        }
//    })
//}
//
//callingFunction(num: 5, closure: incNum)


enum BadLuckError: Error {
    case unlucky
}

func incNum(num: Int, completion: (Int) throws -> Void) rethrows {
    // "Network call"
    try completion(num + 1)
}

func callingFunction(num: Int, closure: (Int, (Int) throws -> Void) throws -> Void ) throws {
    try closure(num, { result in
        print (result)
        if result == 13 {
             throw BadLuckError.unlucky
        }
    })
}

do {
    try callingFunction(num: 12, closure: incNum)
}
catch {
    print ("DONE")
}





