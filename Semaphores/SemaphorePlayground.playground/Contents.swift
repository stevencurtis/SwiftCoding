import Foundation
import PlaygroundSupport

let userPriority = DispatchQueue.init(
    label: "User",
    qos: .userInteractive)
let defaultPriority = DispatchQueue.init(
    label: "Default",
    qos: .default)

//func performNaiveWork(queue: DispatchQueue) {
//    queue.async {
//        for i in 0...10 {
//            print (i, queue.label)
//        }
//    }
//}

//performNaiveWork(queue: userPriority)
//performNaiveWork(queue: defaultPriority)

//var lock = false
//func performNaiveWorkSolution(queue: DispatchQueue) {
//    if !lock {
//        lock = true
//        queue.async {
//            for i in 0...10 {
//                print (i, queue.label)
//            }
//            lock = false
//        }
//    } else {
//        performNaiveWork(queue: queue)
//    }
//}
//
//performNaiveWorkSolution(queue: userPriority)
//performNaiveWorkSolution(queue: defaultPriority)



let semaphore = DispatchSemaphore(value: 1)
func performWork(queue: DispatchQueue) {
    queue.async {
        semaphore.wait()
        for i in 0...10 {
            print (i, queue.label)
            semaphore.signal()
        }
    }
}

performWork(queue: userPriority)
performWork(queue: defaultPriority)

PlaygroundPage.current.needsIndefiniteExecution = true
