```swift
struct BreedsListApiDto: Decodable {
    let message: [String: [String]]
    let status: String

    func toDomain() -> [Breed] {
        var count = 0
        return message.enumerated().flatMap{ dict-> [Breed] in
            count += 1
            return dict.element.value.isEmpty
                ?
                [
                    Breed(identifier: .init(rawValue: count), master: dict.element.key)
                ]
                :
                dict.element.value.enumerated().map {
                    let breed = Breed(identifier: .init(rawValue: count), master: "\(dict.element.key)", sub: "\($0.element)")
                    if $0.offset < dict.element.value.count - 1 {
                        count += 1
                    }
                    return breed
                }
        }
    }
}

public struct Breed: Hashable, Equatable {
    public let identifier: Identifier<Breed, Int>
    public let master: String
    public let sub: String?
    
    init(identifier: Identifier<Breed, Int>, master: String, sub: String? = nil) {
        self.identifier = identifier
        self.master = master
        self.sub = sub
    }
}

```
