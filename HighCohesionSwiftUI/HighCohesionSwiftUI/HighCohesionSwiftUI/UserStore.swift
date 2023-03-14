//
//  UserStore.swift
//  HighCohesionSwiftUI
//
//  Created by Steven Curtis on 13/03/2023.
//

import Foundation

final class UserStore {
    private var user = User(name: "UserName", email: "UserEmail")
    
    func getUser() -> User {
        return user
    }
    
    func saveUser(_ user: User) {
        self.user = user
    }
}
