struct PersonDTO: Decodable {
    let height: String
    let mass: String
    let name: String
    let birth_year: String
    
    func toDomain() -> Person {
        Person(height: height, mass: mass, name: name, birthYear: birth_year)
    }
}
