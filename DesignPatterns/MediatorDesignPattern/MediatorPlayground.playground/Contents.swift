import UIKit

class Request {
    var message: String
    
    init(message: String) {
        self.message = message
    }
}

protocol Mediator {
    func send(request: Request)
}

class RequestMediator: Mediator {
    func send(request: Request) {
        for receiver in receivers {
            receiver.receive(message: request.message)
        }
    }
    
    private var receivers: [Receiver] = []
    func addReceiver(receiver: Receiver) {
        receivers.append(receiver)
    }
}

class Receiver {
    func receive(message: String) {
        print ("Mess \(message)")
    }
}

let myMediator = RequestMediator()
let receiver = Receiver()

myMediator.addReceiver(receiver: receiver)

myMediator.send(request: Request(message: "Test"))



