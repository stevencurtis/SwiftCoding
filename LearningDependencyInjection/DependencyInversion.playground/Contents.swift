import UIKit

//class ClassB{
//    func doIt(){}
//}
//
//class ClassA
//{
//    private var classB: ClassB
//
//    func doSomething()
//    {
//        classB.doIt()
//    }
//    init(_ classB: ClassB) {
//        self.classB = classB
//    }
//}

class Service {
    func doIt(){}
}

class Client
{
    private var service: Service

    func doSomething()
    {
        service.doIt()
    }
    init(_ service: Service) {
        self.service = service
    }
}


// Here the Sender is depended on the reciever of a the specific SpecificReceiver type

// so we need to develop a protocol

//protocol Service {
//    func doIt()
//}
//
//class SpecificService: Service{
//    func doIt(){}
//}
//
//class Client {
//    private var service : Service
//    func doSomething() {
//        service.doIt()
//    }
//    init(_ service: Service) {
//        self.service = service
//    }
//}
//
//let mySender = Client(SpecificService())
