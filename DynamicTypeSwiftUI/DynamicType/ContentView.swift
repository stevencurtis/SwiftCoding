import SwiftUI

struct ContentView: View {
    let viewModel: ContentViewModel
    var body: some View {
        ScrollView {
            LazyVStack {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    ForEach(viewModel.people, id: \.name) { person in
                        Text(person.name)
                            .onAppear {
                                viewModel.loadMoreContentIfNeeded(person: person)
                            }
                        PersonRowView(person: person)
                        PersonDetailView(person: person)
                        Divider()
                    }
                }
            }
        }
        .onAppear(perform: viewModel.fetchPeople)
        .padding()
    }
}

struct PersonRowView: View {
    let person: Person

    var body: some View {
        HStack {
            Text(person.name)
                .font(.headline)
                .frame(width: 100)
                .background(Color.yellow)

            Spacer()
            
            Button(action: {}) {
                Text("Details")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
            }
        }
        .frame(width: 250)
        .background(Color.red.opacity(0.2))
        .padding()
    }
}

struct PersonDetailView: View {
    let person: Person

    var body: some View {
        VStack(alignment: .leading) {
            Text("Height: \(person.height) cm")
                .font(.body)
                .frame(height: 5)
            
            Text("Born in: \(person.birthYear)")
                .font(.subheadline)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(8)
    }
}

#Preview {
    ContentView(viewModel: ContentViewModel())
}
