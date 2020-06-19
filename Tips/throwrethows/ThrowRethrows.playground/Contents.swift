import UIKit


//enum CustomError: Error {
//    case runtimeError(String)
//}

//func addComplete(str: String) -> String {
//    return str + " " + "Complete"
//}
//
//func addHelloWorld(name: String) throws -> String {
//    if name.isEmpty {throw CustomError.runtimeError("No name")}
//    return "Hello, World" + " " + name
//}
//
//func stringBuilder(name: String, closure: (String) throws -> (String)) rethrows {
//    let incompleteString = try closure(name)
//    print (addComplete(str: incompleteString))
//}
//
//try stringBuilder(name: "Lavitha", closure: addHelloWorld)

//try stringBuilder(name: "Lavitha", closure: addHelloWorld)


//enum CustomError: Error {
//    case runtimeError(String)
//}
//
//func addComplete(str: String) -> String {
//    return str + " " + "Complete"
//}
//
//func addHelloWorld(name: String) throws -> String {
//    if name.isEmpty {throw CustomError.runtimeError("No name")}
//    return "Hello, World" + " " + name
//}
//
//func stringBuilder(name: String, closure: (String) throws -> (String)) throws {
//    let incompleteString = try closure(name)
//    if (name == "Steve Curtis") {
//        throw CustomError.runtimeError("Everyone hates you")
//    }
//    print (addComplete(str: incompleteString))
//}
//
//try stringBuilder(name: "Steve Curtis", closure: addHelloWorld)


enum CustomError: Error {
    case runtimeError(String)
}

func addComplete(str: String) -> String {
    return str + " " + "Complete"
}

func addHelloWorld(name: String) throws -> String {
    if name.isEmpty {throw CustomError.runtimeError("No name")}
    return "Hello, World" + " " + name
}

func stringBuilder(name: String, closure: (String) throws -> (String)) throws {
    let incompleteString = try closure(name)
    if (name == "Steve Curtis") {
        print( "Everyone hates you" )
    }
    print (addComplete(str: incompleteString))
}

try stringBuilder(name: "Steve Curtis", closure: addHelloWorld)





var nums = [1,2,13,4]

let luckynums = nums.filter{num in
    return num != 13
}

let luckynumswitherror = try nums.filter{num in
    if num == 13 {
        throw CustomError.runtimeError("I don't process unlucky examples")
    }
    return num != 13
}
