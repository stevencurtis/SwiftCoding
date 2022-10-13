# Lookup UK Postcodes: Can We Use A reusable SearchResultsController
## A working project

# Before we start
Difficulty: Beginner | Easy | **Normal** | Challenging<br/>
This article has been developed using Xcode 12.4, and Swift 5.3.2

## Prerequisites: 
* You will be expected to be aware of how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71) in Swift, or use [Playgrounds](https://medium.com/@stevenpcurtis.sc/coding-in-swift-playgrounds-1a5563efa089) to do the same

## Terminology:
UISearchBarDelegate: Methods that make a search bar control functional

# The setup
In the UK there are a set of postcodes that allow letters and parcels to be delivered quickly to an address. This system is roughly analogous to ZIP codes in the United States.  

There are many applications where we would need to autocomplete a postcode.
This App allows us to ask an endpoint for an autocomplete list of postcodes (`https://api.postcodes.io/postcodes/\(text)/autocomplete`). This is taken place in `SearchResultsViewModel`. Ideally the containing viewcontroller and viewmodel (`ViewController` and `ViewModel`, respectively) would take the user's selection and make another call to return addresses. Unfortunately, this is outside of the scope of this article and once you've selected a postcode (in `SearchResultsController`) it just appears in the table.


# The Project
What we are doing here is setting up SearchResultsController with a SearchResultsViewModel. This is called from the viewmodel and viewcontroller.

# A reusable SearchResultsController


## The lookup

We can hit the function `updateSearchResults` as represented in the following code snippet
```swift
func updateSearchResults(for searchController: UISearchController) {
    guard searchController.isActive else {return}
    if let text = searchController.searchBar.text, !text.isEmpty {
        print("You are searching for", text)
            searchResultsViewModel.searchMeDo(text: text)
    }
}
```

but this can cause issues directly because we are not debouncing. That is, for every single keypress we are making (potentially!) an API call. What happens if we don't get the response before the next keypress? At best it would be a wasted API call, which obviously isn't great.

There are alternatives, but here is one way that I've developed to overcome this problem.

We can use an `@Publisher` which is stored in the `SearchResultsViewModel`

`@Published var keyWordSearch: String = ""`

```swift
func updateSearchResults(for searchController: UISearchController) {
    guard searchController.isActive else {return}
    if let text = searchController.searchBar.text, !text.isEmpty {            self.searchResultsViewModel.keyWordSearch = text
    }
}
```

which in the `SearchResultsViewModel` is bound using the following code:
```swift
private func bind() {
    $keyWordSearch.receive(on: RunLoop.main).debounce(for: .seconds(0.2), scheduler: RunLoop.main)
        .sink { keyword in
            guard !keyword.isEmpty else {
                return
            }
            self.search(with: keyword)
        }.store(in: &cancellable)
}
```

which only then goes to the endpoint to download the autocomplete suggestions (again I've decided to put it in the SearchResultsViewModel):

```swift
func search(with text: String) {
    guard let url = URL(string: "https://api.postcodes.io/postcodes/\(text)/autocomplete") else {return}
    anyNetworkManager.fetch(url: url, method: .get(), completionBlock: { [weak self] result in
        switch result {
        case .success(let data):
            let decoder = JSONDecoder()
            let decoded = try? decoder.decode(Autocomplete.self, from: data)
            self?.autocompleteResults.send(decoded?.result ?? [])
        case .failure:
            break
        }
    }
    )
}
```

# Connect a ViewController to the SearchResultsController

In the `ViewController`:
```swift
private lazy var searchResultsController = SearchResultsController(
    searchResultsViewModel: SearchResultsViewModel(),
    selectedDelegate: self
)
```

note the delegate: This is because we need to obtain the selected string from the `SearchResultsController`:

```swift
extension ViewController: SelectedDelegate {
    func selected(string: String) {
        viewModel.processPostCodes(selectedPostCodes: string)
    }
}
```

which is then set in the initializer, and then called from `didSelectRowAt`:
```swift
selectedDelegate.selected(string: searchResultsViewModel.autocompleteResults.value[indexPath.row])
```

Of course, we need to setcup the search controller.

```swift
private var searchController: UISearchController!

private func setupSearchController() {
    searchController = UISearchController(searchResultsController: searchResultsController)
    searchController.searchResultsUpdater = searchResultsController
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Type your postcode"

    let placeholderAppearance = UILabel.appearance(whenContainedInInstancesOf: [UISearchBar.self])
    placeholderAppearance.font = .systemFont(ofSize: 16)

    navigationItem.searchController = searchController
}
```

# The Code: basic viewmodel and viewcontroller

```swift
class ViewController: UIViewController {
    enum Constants {
        static let reuseIdentifier = "cell"
        static let section = "section"
    }
    
    private let viewModel: ViewModel
    private lazy var tableView: UITableView = UITableView()
    private var dataSource: UITableViewDiffableDataSource<String, String>!
    private var cancellable: Set<AnyCancellable> = []
    private var searchController: UISearchController!
    private lazy var searchResultsController = SearchResultsController(
        searchResultsViewModel: SearchResultsViewModel(),
        selectedDelegate: self
    )
    
    override func loadView() {
        self.view = tableView
    }
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponents()
        setupBindings()
    }
    
    private func applySnapshot(with data: [String]) {
        var currentSnapshot = dataSource.snapshot()
        currentSnapshot.deleteAllItems()
        currentSnapshot.appendSections([Constants.section])
        currentSnapshot.appendItems(data)

        dataSource.apply(currentSnapshot, animatingDifferences: true)
    }
    
    private func setupComponents() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.reuseIdentifier)
        
        setupSearchController()
        
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, postcode in
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifier, for: indexPath)
            cell.textLabel?.text = postcode
            return cell
        }
        )
    }
    
    private func setupSearchController() {
        searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.searchResultsUpdater = searchResultsController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Type your postcode"

        let placeholderAppearance = UILabel.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        placeholderAppearance.font = .systemFont(ofSize: 16)

        navigationItem.searchController = searchController
    }
    
    private func setupBindings() {
        viewModel.postCodes
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { strings in
                if let results = try? strings.get() {
                    self.applySnapshot(with: results)
                }
            })
            .store(in: &cancellable)
    }
}

extension ViewController: SelectedDelegate {
    func selected(string: String) {
        viewModel.processPostCodes(selectedPostCodes: string)
    }
}
```

I guess the `SelectedDelegate` is of some interest here. The protocol itself is as follows (I put it in the `SearchResultsController.swift` file).

```swift
protocol SelectedDelegate {
    func selected(string: String)
}
```
Which is connected to the following viewmodel:
```swift
class ViewModel {
    private(set) var postCodes = CurrentValueSubject<Result<[String], Error>, Never>(.success([]))
    private var cancellable: Set<AnyCancellable> = []

    init() { }

    func processPostCodes(selectedPostCodes: [String]) {
        if let existingPostCodes = try? postCodes.value.get() {
            postCodes.send(.success([selectedPostCodes] + existingPostCodes))
        } else {
            postCodes.send(.success([selectedPostCodes]))
        }
    }
}
```
I've decided to make `postCodes` visible outside the class, but can be adjusted from within the calls.

# The Code: SearchResultsController and SearchResultsViewModel

```swift
final class SearchResultsController: UIViewController, UISearchResultsUpdating {
    enum Constants {
        static let reuseIdentifier = "cell"
        static let section: String = "section"
    }
    let tableView: UITableView = UITableView()
    var dataSource: UITableViewDiffableDataSource<String, String>!
    var cancellable: Set<AnyCancellable> = []
    let searchResultsViewModel: SearchResultsViewModel
    let selectedDelegate: SelectedDelegate

    func updateSearchResults(for searchController: UISearchController) {
        guard searchController.isActive else {return}
        if let text = searchController.searchBar.text, !text.isEmpty {            self.searchResultsViewModel.keyWordSearch = text
        }
    }
    
    init(searchResultsViewModel: SearchResultsViewModel, selectedDelegate: SelectedDelegate) {
        self.searchResultsViewModel = searchResultsViewModel
        self.selectedDelegate = selectedDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponents()
        setupBindings()
    }
    
    private func setupBindings() {
        searchResultsViewModel.autocompleteResults
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { vals in
                self.applySnapshot()
            })
            .store(in: &cancellable)
    }
    
    private func applySnapshot() {
        var currentSnapshot = dataSource.snapshot()
        currentSnapshot.deleteAllItems()
        currentSnapshot.appendSections([Constants.section])
        currentSnapshot.appendItems(searchResultsViewModel.autocompleteResults.value)
        dataSource.apply(currentSnapshot, animatingDifferences: false)
    }
    
    private func setupComponents() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.reuseIdentifier)
        tableView.delegate = self
        dataSource = .init(tableView: tableView, cellProvider: { tableView, indexPath, autocompletion in
            let cell = tableView.dequeueReusableCell(
                withIdentifier: Constants.reuseIdentifier,
                for: indexPath
            )
            cell.textLabel?.text = autocompletion
            return cell
        })
    }
}

extension SearchResultsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedDelegate.selected(string: searchResultsViewModel.autocompleteResults.value[indexPath.row])
        dismiss(animated: true, completion: nil)
    }
}

extension SearchResultsController: UISearchBarDelegate {}
```

```swift
final class SearchResultsViewModel {
    private var anyNetworkManager: AnyNetworkManager<URLSession>
    var autocompleteResults = CurrentValueSubject<[String], Never>([])
    private var cancellable = Set<AnyCancellable>()
    @Published var keyWordSearch: String = ""
    
    init() {
        self.anyNetworkManager = AnyNetworkManager()
        bind()
    }

    init<T: NetworkManagerProtocol> (
        networkManager: T
    ) {
        self.anyNetworkManager = AnyNetworkManager(manager: networkManager)
        bind()
    }
    
    private func bind() {
        $keyWordSearch.receive(on: RunLoop.main).debounce(for: .seconds(0.2), scheduler: RunLoop.main)
            .sink { keyword in
                guard !keyword.isEmpty else {
                    return
                }
                self.search(with: keyword)
            }.store(in: &cancellable)
    }
    
    func search(with text: String) {
        guard let url = URL(string: "https://api.postcodes.io/postcodes/\(text)/autocomplete") else {return}
        anyNetworkManager.fetch(url: url, method: .get(), completionBlock: { [weak self] result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                let decoded = try? decoder.decode(Autocomplete.self, from: data)
                self?.autocompleteResults.send(decoded?.result ?? [])
            case .failure:
                break
            }
        }
        )
    }
}

```

# Conclusion
I hope this article has been of help to you!

Happy coding, and I'll see you next time.

If you've any questions, comments, or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
