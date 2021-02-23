import UIKit
import XCTest

struct Person {
    var name: String
}

// The Factory Method Pattern
// DON'T USE

//class PersonFactory {
//    func createPerson() -> Person? {
//        nil
//    }
//}
//
//class DaveFactory: PersonFactory {
//    override func createPerson() -> Person? {
//        Person(name: "Dave")
//    }
//}
//
//let dave = DaveFactory().createPerson()
//print (dave)

protocol PersonFactory {
    func createPerson() -> Person
}

class DaveFactory: PersonFactory {
    func createPerson() -> Person {
        Person(name: "Dave")
    }
}

let dave = DaveFactory().createPerson()




protocol ResourceFactoryProtocol {
    func create() -> String
}

class ProductionResourceFactory: ResourceFactoryProtocol {
    func create() -> String {
        return "http://prodserver"
    }
}

class DevResourceFactory: ResourceFactoryProtocol {
    func create() -> String {
        return "http://devserver"
    }
}

protocol URLFactoryProtocol {
    func create() -> String?
}


class URLFactory: URLFactoryProtocol {
    enum Environment {
        case prod
        case dev
    }
    
    var env: Environment
    
    init(env: Environment) {
        self.env = env
    }
    
    func create() -> String? {
        switch self.env {
        case .prod:
            return ProductionResourceFactory().create()
        case .dev:
            return DevResourceFactory().create()
        }
    }
}

let urlFactory = URLFactory(env: .dev)
print (urlFactory.create())
