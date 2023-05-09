//
//  ProfileStore.swift
//  SwiftUIArchitecture
//
//  Created by Steven Curtis on 10/04/2023.
//

import Foundation

final class ProfileStore: ObservableObject {
    @Published var user: User?
    
    init(user: User) {
        self.user = user
    }
}

let testProfile = ProfileStore(user: .test())

struct User {
    let firstName: String
    let surname: String
}

extension User {
    static func test(
        firstName: String = "James",
        surname: String = "Dean"
    ) -> Self {
        .init(firstName: firstName, surname: surname)
    }
}
