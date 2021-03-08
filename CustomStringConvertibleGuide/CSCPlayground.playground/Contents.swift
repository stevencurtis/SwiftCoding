import UIKit

struct User {
    let name: String
    let age: Int
}

extension User: CustomStringConvertible {
    var description: String {
        return "\(name) is \(age)"
    }
}

let friend: User = User(name: "Karen", age: 32)
print(friend)
