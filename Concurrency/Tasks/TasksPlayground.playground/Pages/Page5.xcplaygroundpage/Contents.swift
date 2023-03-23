//: [Previous](@previous)

import Foundation

let result = await withTaskGroup(of: Int.self) { group in
  // Add two tasks to the group
  group.addTask {
      print("Task 1")
      return 1
  }
  group.addTask {
      print("Task 2")
      sleep(1)
      return 2
  }

  // Sum up all values returned by tasks
  var sum = 0
  for await value in group {
    sum += value
  }
  
  return sum
}

print(result) // 3
//: [Next](@next)
