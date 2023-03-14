//
//  ContentView.swift
//  LowCohesionSwiftUI
//
//  Created by Steven Curtis on 13/03/2023.
//

import SwiftUI

struct ContentView: View {
    var user: User
    
    var body: some View {
        VStack {
            UserView(user: user)
        }
    }
}

struct UserView: View {
    var user: User
    @State private var showingSheet = false

    var body: some View {
        VStack {
            Text(user.name)
            Text(user.email)
            Button("Edit") {
                showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet) {
                EditUserView(user: user)
            }
        }
    }
}

struct EditUserView: View {
    var user: User
    
    var body: some View {
        Form {
            TextField("Name", text: .constant(user.name))
            TextField("Email", text: .constant(user.email))
            Button("Save") {
                // Save user
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(user: .init(name: "TestName", email: "TestEmail"))
    }
}
