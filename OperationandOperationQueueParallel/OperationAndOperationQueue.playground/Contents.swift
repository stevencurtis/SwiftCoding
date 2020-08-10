import UIKit

let blockOperation: BlockOperation = BlockOperation {
    print("BlockOperation run")
}

let queue = OperationQueue()
//queue.addOperations([blockOperation], waitUntilFinished: true)
queue.addOperation(blockOperation)


class PrintOperation: Operation {
    let stringToPrint: String
    init(stringToPrint: String = "I don't have manners") {
        self.stringToPrint = stringToPrint
        super.init()
    }
    override func main() {
        guard !isCancelled else { return }
        print(stringToPrint)
    }
}

let printOperation = PrintOperation(stringToPrint: "Hello, World!")

printOperation.completionBlock = {
    print("Done!")
}
printOperation.cancel()
//each operation can only be added to a single operationQueue
queue.addOperation(printOperation)



class FirstPrintOperation: Operation {
    let stringToPrint: String
    init(stringToPrint: String = "I don't have manners") {
        self.stringToPrint = stringToPrint
        super.init()
    }
    override func main() {
        guard !isCancelled else { return }
        print(stringToPrint)
    }
}

class SecondPrintOperation: Operation {
    let stringToPrint: String
    init(stringToPrint: String = "This isn't \"Hello, World\"") {
        self.stringToPrint = stringToPrint
        super.init()
    }
    override func main() {
        guard !dependencies.contains(where: { $0.isCancelled }), !isCancelled else {
            return
        }
        print(stringToPrint)
    }}

let firstPrintOperation = FirstPrintOperation(stringToPrint: "FirstPrintOperation")
let secondPrintOperation = SecondPrintOperation(stringToPrint: "SecondPrintOperation")
secondPrintOperation.addDependency(firstPrintOperation)

let multipleOperationsQueue = OperationQueue()
multipleOperationsQueue.addOperations([firstPrintOperation, secondPrintOperation], waitUntilFinished: true)



struct UserModel: Codable {
    var userId: Int
    var id: Int
    var title: String
    var completed: Bool
}

class FetchOperation: Operation {
    let data = """
    {
    "userId": 1,
    "id": 2,
    "title": "test",
    "completed": true
    }
    """
    private(set) var dataFetched: Data?
    override func main() {
        self.dataFetched = data.data(using: .utf8)
    }
}

final class DecodeOperation: Operation {
    var dataFetched: Data?
    private(set) var jsonParsed: [String: Any]?

    typealias CompletionHandler = (_ result: UserModel?) -> Void

    var completionHandler: (CompletionHandler)?

    override func main() {
        guard let dataFetched = dataFetched else { return }
        let decoder = JSONDecoder()
        let content = try? decoder.decode(UserModel.self, from: dataFetched)
        completionHandler?(content)
    }
}

let fetchOperation = FetchOperation()
let decodeOperation = DecodeOperation()

let adapter = BlockOperation() { [unowned fetchOperation, unowned decodeOperation] in
    decodeOperation.dataFetched = fetchOperation.dataFetched
}

adapter.addDependency(fetchOperation)
decodeOperation.addDependency(adapter)

decodeOperation.completionHandler = { decodedData in
    print (decodedData)
}

let decodeOperationsQueue = OperationQueue()
decodeOperationsQueue.addOperations([fetchOperation, decodeOperation, adapter], waitUntilFinished: true)


