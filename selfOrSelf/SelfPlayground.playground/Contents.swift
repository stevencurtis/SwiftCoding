import UIKit

struct Person {
    let name: String
    init(name: String) {
        self.name = name
    }
}

extension Person {
    static func test(name: String = "Rosa") -> Self {
        .init(name: name)
    }
    
    static func createPeople(count: Int) -> [Self] {
        Array(repeating: test(), count: count)
    }
}

let you = Person(name: "YourName")
print(Person.test())

public protocol Instantiable {
    static func instantiateFromNib() -> Self
}

extension UIViewController: Instantiable {
    public static func instantiateFromNib() -> Self {
        return self.init(
            nibName: String(describing: self),
            bundle: Bundle(for: self)
        )
    }
}
