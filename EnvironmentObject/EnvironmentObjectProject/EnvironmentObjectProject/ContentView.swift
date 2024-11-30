import SwiftUI
import Combine


final class UserSession: ObservableObject {
    @Published var isLoggedIn = false
    @Published var username: String = "Guest"
    
    func logIn(name: String) {
        username = name
        isLoggedIn = true
    }
    
    func logOut() {
        username = "Guest"
        isLoggedIn = false
    }
}

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var session: UserSession
    @State private var name: String = ""
    
    var body: some View {
        if !session.isLoggedIn {
            VStack {
                TextField("Enter your name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Button("Log In") {
                    session.logIn(name: name)
                }
            }
            .padding()
        } else {
            LoggedInView()
        }
    }
}

struct LoggedInView: View {
    @EnvironmentObject var session: UserSession
    
    var body: some View {
        VStack {
            Text("Welcome, \(session.username)")
            Button("Log Out") {
                session.logOut()
            }
        }
    }
}

#Preview("Logged Out View") {
    let loggedInSession = UserSession()
    return ContentView()
        .environmentObject(loggedInSession)
}

#Preview("Logged In View") {
    let loggedInSession = UserSession()
    loggedInSession.logIn(name: "John Doe")
    return ContentView()
        .environmentObject(loggedInSession)
}
