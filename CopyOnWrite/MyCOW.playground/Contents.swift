import UIKit


//struct Address {
//    var road: String
//}
//
//class Person {
//    var name = String()
//    var personaddress : Address
//
//    init(name: String, address: Address){
//        self.name = name
//        self.personaddress = address
//    }
//
//    var address : Address {
//        get { return personaddress }
//        set {
//            if (!isKnownUniquelyReferenced(personaddress)) {
//                    return
//            }
//            personaddress =  newValue
//        }
//    }
//}
//
////var dave = Person(name: "dave", personaddress: Address(road: "AAA"))
//var dave = Person(name: "dave", address: Address(road: "road"))
//dave.address = Address(road: "111")
//print (dave.address.road)


struct Address {
    var streetAddress: String
    var city: String
    var state: String
    var postalCode: String
}
class Person {
    var name: String
    var address: Address
    
    init(name: String, address: Address) {
        self.name = name
        self.address = address
    }
}
struct Bill {
    let amount: Float
    var _billedTo: Person
    
    private var billedToForRead: Person {
        return _billedTo
    }
    
    private var billedToForWrite: Person {
        mutating get {
            _billedTo = Person(name: _billedTo.name, address: _billedTo.address)
            return _billedTo
        }
    }
    
    init(amount: Float, billedTo: Person) {
        self.amount = amount
        _billedTo = Person(name: billedTo.name, address: billedTo.address)
    }
    
    mutating func updateBilledToAddress(address: Address) {
        billedToForWrite.address = address
    }
    
    mutating func updateBilledToName(name: String) {
        billedToForWrite.name = name
    }
}

let kingsLanding = Address(streetAddress: "1 King Way", city: "Kings Landing", state: "Westeros", postalCode: "12345")

let billPayer = Person(name: "Robert", address: kingsLanding)

billPayer.name = "eric"

var myBill = Bill(amount: 99.99, billedTo: billPayer)
myBill._billedTo.name // should not access, should be private
//myBill.updateBilledToName(name: "Eric")



