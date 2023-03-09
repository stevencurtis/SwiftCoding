import UIKit

let json = """
{
    "people":
    [
        {
            "name": "Dr",
            "profession": "DOCTOR"
        }
        ,
        {
            "name": "James",
            "profession": "ACTOR"
        }
    ]
}
"""

struct People: Decodable {
    let people: [Person]
}

extension People: CustomStringConvertible {
    var description: String {
        return people.map{ $0.description }.joined(separator: "\n")
    }
}

struct Person: Decodable {
    let name: String
    let profession: Profession
}

extension Person: CustomStringConvertible {
    var description: String {
        return "\(name) is a \(profession)"
    }
}

enum Profession: String, Decodable {
    case doctor = "DOCTOR"
    case actor = "ACTOR"
}

extension Profession: CustomStringConvertible {
    var description: String {
        switch self {
        case .doctor:
            return "Doctor"
        case .actor:
            return "Actor"
        }
    }
}

let decoder = JSONDecoder()
let person = try! decoder.decode(People.self, from: json.data(using: .utf16)!)
print(person)
