//: [Previous](@previous)

import Foundation

// This will always run in order using the playground. Use a device!

let task1 = Task.detached {
    for i in 0..<10 {
        sleep(1) // optional here
        print("Task 1: \(i)")
    }

    return "Task 1: Complete"
}

let task2 = Task.detached {
    for i in 0..<10 {
        print("Task 2: \(i)")
    }
    return "Task 2: Complete"
}

Task {
    print(await task1.value)
}

Task {
    print(await task2.value)
}


print("Tasks are running")


//: [Next](@next)
