struct PostDTO: Decodable {
    let title: String
    
    func toDomain() -> Post {
        Post(title: title)
    }
}
