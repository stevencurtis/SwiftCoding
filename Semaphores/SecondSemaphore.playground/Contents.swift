import UIKit
import PlaygroundSupport

func performUsingSemaphore() {
    let dq1 = DispatchQueue.init(
    label: "firstqueue",
    qos: .default)
    let dq2 = DispatchQueue.init(
    label: "dq2",
    qos: .default)
    let semaphore = DispatchSemaphore(value: 1)

    for i in 1...3 {
        dq1.async {
            _ = semaphore.wait(timeout: DispatchTime.distantFuture)
            print(i, dq1.label)
            semaphore.signal()
        }
    }
    for i in 1...3 {
        dq2.async {
            _ = semaphore.wait(timeout: DispatchTime.distantFuture)
            print(i, dq2.label)
            semaphore.signal()
        }
    }
}

performUsingSemaphore()

PlaygroundPage.current.needsIndefiniteExecution = true
