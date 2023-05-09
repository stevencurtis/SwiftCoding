//
//  UserView.swift
//  SwiftUIArchitecture
//
//  Created by Steven Curtis on 10/04/2023.
//

import SwiftUI

struct UserView: View {
    @ObservedObject var userStore: ProfileStore
    var body: some View {
        VStack(alignment: .leading) {
            Text(userStore.user?.firstName ?? "")
            Text(userStore.user?.surname ?? "")
            Button("Change username") { }
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(userStore: testProfile)
    }
}
