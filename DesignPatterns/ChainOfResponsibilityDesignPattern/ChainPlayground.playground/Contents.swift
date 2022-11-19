import Foundation

enum Animal: Int, Comparable {
    case cat
    case dog
    case wolf
    case fox
    case elephant
    static func < (lhs: Animal, rhs: Animal) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

protocol Handler {
    var next: Handler? { get }
    func handle(request: Animal)
}

// Handers can either process a request, or pass it to the next handler in the chain
class DogHandler: Handler {
    func handle(request: Animal) {
        if request > .dog {
            next?.handle(request: request)
        } else {
            print ("Handled by the dog handler")
        }

    }
    var next: Handler?
}

class WolfHandler: Handler {
    func handle(request: Animal){
        if request > .wolf {
            next?.handle(request: request)
        } else {
            print ("Handled by the wolf handler")
        }
    }
    var next: Handler?
}

class ElephantHandler: Handler {
    func handle(request: Animal){
        if request > .elephant {
            next?.handle(request: request)
        } else {
            print ("Handled by the elephant handler")
        }
    }
    var next: Handler?
}


let dogHandler = DogHandler()
let wolfHandler = WolfHandler()
let elephantHandler = ElephantHandler()

dogHandler.next = wolfHandler
wolfHandler.next = elephantHandler

dogHandler.handle(request: Animal.cat) // handled by the dog handler
dogHandler.handle(request: Animal.elephant) // handled by the elephant handler

