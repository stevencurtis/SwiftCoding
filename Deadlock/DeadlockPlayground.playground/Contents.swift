import Foundation
import PlaygroundSupport

// https://medium.com/swiftly-swift/a-quick-look-at-semaphores-6b7b85233ddb

let higherPriority = DispatchQueue.global(qos: .userInitiated)
let lowerPriority = DispatchQueue.global(qos: .utility)

let semaphoreA = DispatchSemaphore(value: 1)
let semaphoreB = DispatchSemaphore(value: 1)

func asyncPrint(queue: DispatchQueue, symbol: String, firstResource: String, firstSemaphore: DispatchSemaphore, secondResource: String, secondSemaphore: DispatchSemaphore) {
  func requestResource(_ resource: String, with semaphore: DispatchSemaphore) {
    print("\(symbol) waiting resource \(resource)")
    semaphore.wait()  // requesting the resource
  }
  
  queue.async {
    requestResource(firstResource, with: firstSemaphore)
    for i in 0...10 {
      if i == 5 {
        requestResource(secondResource, with: secondSemaphore)
      }
      print(symbol, i)
    }
    
    print("\(symbol) releasing resources")
    firstSemaphore.signal() // releasing first resource
    secondSemaphore.signal() // releasing second resource
  }
}

asyncPrint(queue: higherPriority, symbol: "🔴", firstResource: "A", firstSemaphore: semaphoreA, secondResource: "B", secondSemaphore: semaphoreB)
asyncPrint(queue: lowerPriority, symbol: "🔵", firstResource: "B", firstSemaphore: semaphoreB, secondResource: "A", secondSemaphore: semaphoreA)

PlaygroundPage.current.needsIndefiniteExecution = true

