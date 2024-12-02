import SwiftUI

struct ContentView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @FocusState private var focusedField: Field?
    
    enum Field: Hashable {
        case firstName
        case lastName
    }

    var body: some View {
        Form {
            TextField("First Name", text: $firstName)
                .focused($focusedField, equals: .firstName)
                .submitLabel(.next)
                .onSubmit {
                    withTransaction(Transaction(animation: nil)) {
                        focusedField = .lastName
                    }
                }
            
            TextField("Last Name", text: $lastName)
                .focused($focusedField, equals: .lastName)
                .submitLabel(.done)
                .onSubmit {
                    focusedField = nil
                }
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button("Previous") {
                    focusedField = .firstName
                }
                Button("Next") {
                    focusedField = .lastName
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
