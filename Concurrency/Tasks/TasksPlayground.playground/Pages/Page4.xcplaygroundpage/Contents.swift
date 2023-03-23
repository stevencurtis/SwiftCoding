//: [Previous](@previous)

import Foundation

func task1() async -> String {
    for i in 0..<10 {
        sleep(1)
        print("Task 1: \(i)")
    }
    return "Task 1: Complete"
}

func task2() async -> String {
    for i in 0..<10 {
        print("Task 2: \(i)")
    }
    return "Task 2: Complete"
}

func runTasks() async -> [String] {
    var items: [String] = []
    try? await withThrowingTaskGroup(of: String.self) { group in
        group.addTask {
            let result = await task1()
            return result
        }

        group.addTask {
            let result = await task2()
            return result
        }
        
        for try await item in group {
            items.append(item)
        }
    }
    return items
}

await runTasks() // ["Task 1: Complete", Task 2: Complete]

//: [Next](@next)
