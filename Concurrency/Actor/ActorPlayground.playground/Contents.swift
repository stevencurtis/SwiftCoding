import UIKit

actor Counter {
  private var value = 0
  
  func next() async -> Int {
    let current = value
    value = value + 1
    return current
  }
}

let counter1 = Counter()
await print(counter1.next())
await print(counter1.next())
