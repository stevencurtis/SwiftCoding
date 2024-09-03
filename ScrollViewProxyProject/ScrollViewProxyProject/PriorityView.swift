import SwiftUI

struct Book: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let author: String
    let genre: String
}

struct AdvancedScrollViewReaderExample: View {
    @State private var books: [Book] = [
        Book(title: "1984", author: "George Orwell", genre: "Dystopian"),
        Book(title: "To Kill a Mockingbird", author: "Harper Lee", genre: "Classic"),
        Book(title: "The Great Gatsby", author: "F. Scott Fitzgerald", genre: "Classic"),
        Book(title: "Crime and Punishment", author: "Fyodor Dostoevsky", genre: "Classic"),
        Book(title: "Moby Dick", author: "Herman Melville", genre: "Classic"),
        Book(title: "Pride and Prejudice", author: "Jane Austen", genre: "Classic"),
        Book(title: "The Catcher in the Rye", author: "J.D. Salinger", genre: "Classic"),
        Book(title: "War and Peace", author: "Leo Tolstoy", genre: "Classic"),
        Book(title: "Jane Eyre", author: "Charlotte Brontë", genre: "Classic"),
        Book(title: "Wuthering Heights", author: "Emily Brontë", genre: "Classic"),
        Book(title: "Brave New World", author: "Aldous Huxley", genre: "Dystopian"),
        Book(title: "Fahrenheit 451", author: "Ray Bradbury", genre: "Dystopian"),
        Book(title: "The Handmaid's Tale", author: "Margaret Atwood", genre: "Dystopian"),
        Book(title: "The Road", author: "Cormac McCarthy", genre: "Dystopian"),
        Book(title: "Dune", author: "Frank Herbert", genre: "Science Fiction"),
        Book(title: "Neuromancer", author: "William Gibson", genre: "Science Fiction"),
        Book(title: "Foundation", author: "Isaac Asimov", genre: "Science Fiction"),
        Book(title: "The Left Hand of Darkness", author: "Ursula K. Le Guin", genre: "Science Fiction"),
        Book(title: "Snow Crash", author: "Neal Stephenson", genre: "Science Fiction"),
        Book(title: "The Hobbit", author: "J.R.R. Tolkien", genre: "Fantasy"),
        Book(title: "The Lord of the Rings", author: "J.R.R. Tolkien", genre: "Fantasy"),
        Book(title: "A Game of Thrones", author: "George R.R. Martin", genre: "Fantasy"),
        Book(title: "The Name of the Wind", author: "Patrick Rothfuss", genre: "Fantasy"),
        Book(title: "The Lies of Locke Lamora", author: "Scott Lynch", genre: "Fantasy"),
        Book(title: "The Hound of the Baskervilles", author: "Arthur Conan Doyle", genre: "Mystery"),
        Book(title: "Gone Girl", author: "Gillian Flynn", genre: "Mystery"),
        Book(title: "The Girl with the Dragon Tattoo", author: "Stieg Larsson", genre: "Mystery"),
        Book(title: "The Da Vinci Code", author: "Dan Brown", genre: "Mystery"),
        Book(title: "And Then There Were None", author: "Agatha Christie", genre: "Mystery")
    ]
    @State private var searchText = ""
    @State private var selectedGenre: String?
    @State private var scrollTarget: UUID?
    
    let genres = ["Classic", "Dystopian", "Science Fiction", "Fantasy", "Mystery"]
    
    var body: some View {
        VStack {
            TextField("Search books", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(genres, id: \.self) { genre in
                        Button(action: {
                            selectedGenre = genre == selectedGenre ? nil : genre
                        }) {
                            Text(genre)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(genre == selectedGenre ? Color.blue : Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
            }.padding(.horizontal)
            
            ScrollViewReader { proxy in
                List {
                    ForEach(filteredBooks) { book in
                        BookRow(book: book)
                            .id(book.id)
                            .listRowSeparator(.hidden)
                    }
                }
                .onChange(of: scrollTarget) { _, newValue in
                    if let target = newValue {
                        defer {
                            scrollTarget = nil
                        }
                        withAnimation {
                            proxy.scrollTo(target, anchor: .center)
                        }
                    }
                }
                .onChange(of: selectedGenre) { _, _ in
                    if let firstBook = filteredBooks.first {
                        scrollTarget = firstBook.id
                    }
                }
            }
            
            HStack {
                Button("Scroll to Top") {
                    scrollTarget = filteredBooks.first?.id
                }
                Spacer()
                Button("Scroll to Bottom") {
                    scrollTarget = filteredBooks.last?.id
                }
            }.padding()
        }
    }
    
    var filteredBooks: [Book] {
        books.filter { book in
            (searchText.isEmpty || book.title.lowercased().contains(searchText.lowercased()) 
             || book.author.lowercased().contains(searchText.lowercased()))
            && (selectedGenre == nil || book.genre == selectedGenre)
        }
    }
}

struct BookRow: View {
    let book: Book
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(book.title)
                .font(.headline)
            Text(book.author)
                .font(.subheadline)
            Text(book.genre)
                .font(.caption)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
        }
        .padding()
    }
}

struct AdvancedScrollViewReaderExample_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedScrollViewReaderExample()
    }
}
