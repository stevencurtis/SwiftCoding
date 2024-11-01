import Foundation

struct UserDTO: Decodable, Identifiable {
    let id: Int
    let username: String
}
