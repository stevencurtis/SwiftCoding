//
//  ContentView.swift
//  ViewBuilderComposition
//
//  Created by Steven Curtis on 17/08/2023.
//

import SwiftUI

struct User {
    var name: String
    var bio: String
}

struct ContentView: View {
    var user: User

    var body: some View {
        VStack {
            VStack {
                ProfilePicture()
                UserName(name: user.name)
                UserBiography(bio: user.bio)
            }
            userProfileView(
                user: user
            )
        }
        .padding()
    }
}

@ViewBuilder
func userProfileView(user: User) -> some View {
    ProfilePicture()
    UserName(name: user.name)
    UserBiography(bio: user.bio)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(user: User(name: "test", bio: "bio"))
    }
}
