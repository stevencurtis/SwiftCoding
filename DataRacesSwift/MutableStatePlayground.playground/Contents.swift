import UIKit

//class Counter {
//    var value = 0
//    func increment() -> Int {
//        value += 1
//        return value
//    }
//}
//
//let counter = Counter()
//Task.detached {
//    print(counter.increment())
//}
//
//Task.detached {
//    print(counter.increment())
//}
//
//RunLoop.main.run()


private var name: String = ""

func updateName() {
    DispatchQueue.global().async {
        name.append("Hello")
    }
    
    DispatchQueue.global(priority: .background).async {
        name.append("2")
    }
    
    print(name)
}

updateName()

struct Counter {
    var value = 0
    mutating func increment () -> Int {
        value = value + 1
        return value
    }
}

struct Foo {
    static var counter = Counter()
}

Task {
    var counter = Counter()
    Task.detached {
        print(Foo.counter.increment()) // no error
//        print(counter.increment()) // error
    }
    Task.detached {
        print(Foo.counter.increment()) // no error
//        print(counter.increment()) // error
    }
}

