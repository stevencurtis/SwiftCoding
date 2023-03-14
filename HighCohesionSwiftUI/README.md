# High Cohesion SwiftUI Code
## It's important

Cohesion is a principle of software design which refers to the degree to which elements within a module (or component). High cohesion is preferable and is associated with reusability, robustness and reliability and often correlates to loose coupling.

Wait, what? Let's see some examples. What could possibly go wrong (let me know in the comments).

# Before we start

Difficulty: Beginner | **Easy** | Normal | Challenging
This article has been developed using Xcode 14.2, and Swift 5.7.2

## Prerequisites:
* You will be expected to be able to create [a SwiftUI project](https://stevenpcurtis.medium.com/use-swiftui-in-a-playground-4f8a74181593)

## Terminology
Cohesion: the degree to which the elements inside a module belong together

# A high cohesion example
We wish to describe high cohesion through the use of small, focussed views and view models which have well-defined tasks and communicate through well-designed interfaces.

The following example does not represent perfection (it's not finished, and I'm not thrilled about how I inject the user to the view model) but it does give some idea about how high cohesion might apply to a `SwiftUI` project. 

Here is the code!

```swift
//  HighCohesionSwiftUIApp.swift

import SwiftUI

@main
struct HighCohesionSwiftUIApp: App {
    let userStore = UserStore()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: .init(userStore: userStore))
        }
    }
}

//  UserStore.swift

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

//  User.swift

import Foundation

struct User {
    let name: String
    let email: String
}

//  ContentView.swift

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: UserViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.userName)
            Button("Edit") {
                viewModel.showEditView.toggle()
            }
        }
        .sheet(isPresented: $viewModel.showEditView) {
            showEditUserView(viewModel: viewModel)
        }
    }
}

extension ContentView {
    private func showEditUserView(viewModel: UserViewModel) -> some View {
        Form {
            TextField("Name", text: $viewModel.userName)
            TextField("Email", text: $viewModel.userEmail)
            Button("Save") {
                viewModel.saveUser()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: .init(userStore: UserStore()))
    }
}

//  UserViewModel.swift

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
```

# A low cohesion example
The following example is less well organized and the constituent components have unclear responsibilities. 

Here is the code, and then we will take a look:

```swift
//  LowCohesionSwiftUI

import SwiftUI

@main
struct LowCohesionSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(user: .init(name: "username", email: "useremail"))
        }
    }
}

//  User.swift

import Foundation

struct User {
    let name: String
    let email: String
}

//  ContentView.swift

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
```

In the code above, the `UserView` displays the user's name and email but also handles the logic for showing the edit view. `EditUserView` handles the editing of the user's details (or would if the coder were completely finished) but does not communicate with the `UserView` or `ContentView`.

It's not great.

# Conclusion
Thank you for reading.

High cohesion is one of those fundamental principles of software design which we should all consider including in our code. It promotes modularity and robust code.

This makes sense if our resultant code is easier to maintain, more reusable and robust. We would then call that code high cohesion.

This would be something we would need to prioritise, but of course balanced against the other demands on our codebase.
