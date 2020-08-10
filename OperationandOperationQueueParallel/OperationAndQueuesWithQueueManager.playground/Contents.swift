import Foundation


class QueueManager {
    lazy var queue: OperationQueue = {
        let queue = OperationQueue()
        return queue;
    }()

    static let shared = QueueManager()
    
    // MARK: - Add Operation
    func enqueue(_ operation: Operation) {
        queue.addOperation(operation)
    }
}

let queueManager = QueueManager()

