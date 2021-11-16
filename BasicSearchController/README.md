# A Basic SearchViewController
## A simple mini project

# Prerequisites:
You will need to be familiar with the basics of [Swift and able to start a Playground (or similar)](https://medium.com/@stevenpcurtis.sc/coding-in-swift-playgrounds-1a5563efa089)
and be able to create a [`UITableView` programatically](https://stevenpcurtis.medium.com/the-programmatic-uitableview-example-e6936d5557af)

# Before we start
Difficulty: Beginner | **Easy** | Normal | Challenging
This article has been developed using Xcode 13.0, and Swift 5.3

# Terminology:
SearchViewController: A view controller that manages the display of search results based on interactions with a search bar.

# This Project
Oh, if you'd like the code for this it is [https://github.com/stevencurtis/SwiftCoding/tree/master/BasicSearchController](https://github.com/stevencurtis/SwiftCoding/tree/master/BasicSearchController)<br>

## What it does
The idea is that you can type to search in this tableview:
[Images/finished.png](Images/finished.png)

and if you type in letters (not any number) the table will display letters, if not (i.e. if you type numbers) this will display numbers.

This involved the use of a closure for the `UITableView`, which brings us onto...

## UITableView
You know what, making a project with a `SearchViewController` shouldn't be difficult at all. The problem is that description in terminology, it makes it sound much more difficult than it is. 

Then I see I haven't created a tutorial on this previously. So I think that is time to put that right.

Now if you want to see a video about how to set up a `UITableView` please look at the following video: [https://youtu.be/VBJODUzYKqk](https://youtu.be/VBJODUzYKqk)

## Setting up the SearchViewController
I've created a rather nice function to set up the SearchViewController

```swift
func setupSearchController() {
    searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
    searchController.searchBar.placeholder = "Search for your data"
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.delegate = self
    searchController.searchBar.keyboardType = .default

    let placeholderAppearance = UILabel.appearance(whenContainedInInstancesOf: [UISearchBar.self])
    placeholderAppearance.font = .systemFont(ofSize: 16)
    navigationController?.navigationBar.barTintColor = .systemBackground
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = true
}
```

## Delegates
This isn't enough for us though. Much like a `UITableView` has delegates, here we need to conform to `UISearchBarDelegate`.

I've placed this conformance into a delegate

```swift
func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    viewModel.search(searchText)
}
```

which then links to the `viewModel`. This means when the user types anything into the search controller.

We then link to the ViewModel so we can add it into our code here:

```swift
class ViewModel {
    var data: [String] = ["1", "2", "3"]
    
    var dataChanged: (() -> ())?

    func search(_ text: String) {
        if CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: text)) {
            data = ["1", "2", "3"]
            dataChanged?()
        } else {
            data = ["a", "b", "c"]
            dataChanged?()
        }
    }
}
```

# Conclusion
It should be relatively trivial to get a `SearchViewController` into n app programatically. So in order to make that easy for us, I've created this rather lovely Medium article.

I hope that it's helped you. Thank you for reading.

Subscribing to Medium using [this link](https://stevenpcurtis.medium.com/membership) shares some revenue with me.

If you’ve any questions, comments or suggestions [please hit me up on Twitter](https://twitter.com/stevenpcurtis)
