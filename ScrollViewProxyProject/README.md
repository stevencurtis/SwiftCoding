# An Introduction to SwiftUI's ScrollViewReader
## Programmatically Scrolling a ScrollView

SwiftUI is a rather nice development experience. The idea is that we can make adaptive UI for Apple platforms, reducing boilerplate code and even increasing productivity.

I like many of the tools that Apple have provided for us, and recently came across the `ScrollViewReader` that enables control of the scrolling behaviour of a `ScrollView` programmatically.


## The ScrollViewReader
In iOS 14 Apple have provided us with a `ScrollViewReader`, where we can wrap `ScrollView` content inside a `ScrollViewReader` to gain access to the ability to scroll to any specific view as identified by a unique identifier.

Apple have [documentation which includes an example](https://medium.com/r/?url=https%3A%2F%2Fdeveloper.apple.com%2Fdocumentation%2Fswiftui%2Fscrollviewreader), but that presupposes familiarity with the [namespace property wrapper](https://medium.com/r/?url=https%3A%2F%2Fstevenpcurtis.medium.com%2Fswiftuis-namespace-01a904402856) to identify views and I feel that can create an additional barrier to understanding this code.

So the `ScrollViewReader` itself is particularly useful if you wish to navigate to a specific item in a list or a collection (perhaps based on user input).

## The Basic Example
A button that scrolls a ScrollView to the 25th item? Now you can with ScrollViewReader

![images/basicsmaller.png](images/basicsmaller.png)<br>

So the code (below) uses `ScrollViewReader` to wrap a `ScrollView`. Each item is assigned an id using the .id modifier (that can bind to any `Hashable` type, in this case an `Int`). We then put a button (outside the `ScrollView`) that has an action that scrolls to the item with an `ID` of 25.

```swift
struct BasicView: View {
    var body: some View {
        ScrollViewReader { proxy in
            Button("Scroll to item 25") {
                withAnimation {
                    proxy.scrollTo(25, anchor: .center)
                }
            }
            ScrollView {
                VStack {
                    ForEach(0..<50, id: \.self) { index in
                        Text("Item \(index)")
                            .id(index) // Assign an ID to each view
                            .padding()
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(8)
                            .padding(.vertical, 2)
                    }
                }
            }
            .padding()
        }
    }
}
```

## A Fun Example
Things can be fun if we implement a filter for a `List` of books. `@State` is used to manage the UI state and `ScrollViewReader` is used for programmatic scrolling. We use the `UUID` to identify each view, and since this is unique (obviously) we can ensure we are able to programmatically scroll to the correct view.

We can scroll to the bottom and this makes it a little nicer for the user to use (especially when it is a large list).

![images/advancesmaller.png](images/advancesmaller.png)<br>

Here is the code:

```swift
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
            (searchText.isEmpty || book.title.lowercased().contains(searchText.lowercased()) || book.author.lowercased().contains(searchText.lowercased())) &&
            (selectedGenre == nil || book.genre == selectedGenre)
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
```

# Practical Applications
Here are some suggested ideas for using ScrollViewReader

## Errors
If a user submits a form with an error, scroll to the first field that needs attention

## Jump to Section
This can work like an index where users can navigate to a specific section.

## Highlight Added Content
If you allow users to add items to a list, you can navigate the user to the newly added item.

# Best Practices
## Consider Performance
As always with long lists performance should be considered. `LazyVStack` and `LazyHStack` are usually good choices for large datasets.
Likewise animations should monitored to make sure that they display correctly.

## User Expectations
It's important to realize that pushing the user around can sometimes lead to a poor user experience. As developers we should always ensure that scrolling feels natural and intuitive.

# Conclusion
A `ScrollViewReader` can enhance the interactivity of apps by allowing programmatic scrolling control.

Remember there is [Apple's documentation](https://medium.com/r/?url=https%3A%2F%2Fdeveloper.apple.com%2Fdocumentation%2Fswiftui%2Fscrollviewreader) to further help you out, and make your journey with this particular feature a little easier.
