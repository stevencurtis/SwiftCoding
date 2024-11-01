import Foundation

struct User: Identifiable {
    let id = UUID()
    let username: String
    
    init(user: UserDTO) {
        username = user.username
    }
}
