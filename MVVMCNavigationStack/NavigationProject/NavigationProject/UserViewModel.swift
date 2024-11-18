import SwiftUI

final class UserViewModel: ObservableObject {
    let user: User

    init(user: User) {
        self.user = user
    }
}
