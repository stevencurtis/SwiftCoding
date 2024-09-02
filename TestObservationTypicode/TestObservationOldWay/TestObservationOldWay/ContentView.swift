
import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        ScrollView {
            LazyVStack{
                ForEach(viewModel.posts) { post in
                    Text(post.title)
                }
            }
        }
        .onAppear {
            viewModel.getPosts()
        }
        .alert(
            "Login failed.",
            isPresented: Binding(get: { viewModel.error != nil }, set: { _,_ in viewModel.error = nil })
        ) {
            Button("OK") {
                // TODO: retry mechanism
            }
        } message: {
            Text(viewModel.error?.localizedDescription ?? "Something went wrong")
        }
        .padding()
    }
}

#Preview {
    ContentView(viewModel: ViewModel(service: PostService()))
}
