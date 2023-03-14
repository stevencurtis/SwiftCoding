//
//  UserViewModel.swift
//  HighCohesionSwiftUI
//
//  Created by Steven Curtis on 13/03/2023.
//

import SwiftUI

final class UserViewModel: ObservableObject {
    @Published var userName: String
    @Published var userEmail: String
    @Published var showEditView = false
    let userStore: UserStore
    
    init(userStore: UserStore) {
        self.userStore = userStore
        let user = userStore.getUser()
        self.userName = user.name
        self.userEmail = user.email
    }
    
    func saveUser() {
        userStore.saveUser(User(name: userName, email: userEmail))
    }
}
