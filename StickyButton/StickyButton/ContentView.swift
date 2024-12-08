import SwiftUI

struct ContentView: View {
    @State private var text: String = ""
    @FocusState private var isTextFieldFocused: Bool
    var body: some View {
        VStack {
            ScrollView {
                TextField("Type something...", text: $text)
                    .focused($isTextFieldFocused)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                ForEach(0..<10) { _ in
                    Text("This is text content")
                        .padding()
                }
            }
            Spacer()
            Button(action: {
                isTextFieldFocused = false
            }) {
                Text("Sticky Button")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}
