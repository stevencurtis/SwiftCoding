import UIKit

@propertyWrapper
struct Wrapper<T> {
   var wrappedValue: T
}

struct People {
    @Wrapper var names: [String] = ["Saanvi"]
}

var people = People()
print (people.names)



@propertyWrapper
struct ISO8601DateFormatted {
    static private let formatter = ISO8601DateFormatter()
    var projectedValue: String { ISO8601DateFormatted.formatter.string(from: wrappedValue) }
    var wrappedValue: Date
}

struct Form {
    @ISO8601DateFormatted var createdAt: Date
}

let user = Form(createdAt: Date())
user.createdAt // "Jul 6, 2020 at 8:56 AM"
user.$createdAt // "2020-07-06 07:56:24 +0000\n"


type(of: user.createdAt) // Foundation.Date.Type
type(of: user.$createdAt) // String.Type

