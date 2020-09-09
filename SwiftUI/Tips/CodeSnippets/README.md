# Swift UI Tips
## A collection of tips I've found to be useful in SwiftUI
Perhaps not worthy of a full article, but useful nonetheless

## Contents

[Lazily instantiate a view from NavigationLink](#Lazily-instantiate-a-view-from-NavigationLink)<br>

# The Code
## Lazily instantiate a view from NavigationLink

```swift
struct LazyView<Content: View>: View {
    var content: () -> Content
    var body: some View {
        self.content()
    }
}
```

which can then be instantiated from the List using something like the following:

```swift
        NavigationView {
            List {
                ForEach(animals, id: \.self) {
                    animal in
                    NavigationLink(destination: LazyView {
                        DetailView(viewModel: DetailViewModel(text: animal))
                        })
                    {
                        Text(animal)
                    }
                }
            }
            .navigationBarTitle("Animatls")
            .listStyle(GroupedListStyle())
        }
```
Nice!