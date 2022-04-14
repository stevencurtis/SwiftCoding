# Make All Your Swift UIKit Views a UITableView
## It's possible, but is it preferable?

Imagine that you are working to create views, and making each one have subviews placed in a scrollview. 
Nothing wrong with that, but it's quite a bit of work isn't it?
What if we use UITableView as our basic view? How would we go about something like this.

Read on to find out all the details! Please do also take a look at the accompanying code, I personally find it easier to have the whole code in front of me when looking at an article like this.
Difficulty: Beginner | Easy | Normal | **Challenging**
This article has been developed using Xcode 13.1, and Swift 5.5.1

## Prerequisites:
You will be expected to be aware of how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71) in Swift, and creating [UITableViewCell custom classes](https://medium.com/r/?url=https%3A%2F%2Fstevenpcurtis.medium.com%2Fcreate-a-uitableviewcell-programmatically-88d453380dcf) programatically. I've got some [enum here with associated values too](https://medium.com/r/?url=https%3A%2F%2Fstevenpcurtis.medium.com%2Fenums-in-swift-f242a571bf9f).

## Terminology

UIScrollView: A view that allows the scrolling and zooming of its contained views
UITableView: A view that presents data using rows arranged in a single column
UITableViewCell: The visual representation of a single row in a table view
UIView: An object that manages the content for a rectangular area on the screen

## The Why
You know what, I've [hated implementing views](https://medium.com/r/?url=https%3A%2F%2Fstevenpcurtis.medium.com%2Fuiscrollview-with-auto-layout-implemented-in-interface-builder-5338c60db17a) with [UIScrollView](https://medium.com/r/?url=https%3A%2F%2Fstevenpcurtis.medium.com%2Fuiscrollview-with-auto-layout-implemented-in-interface-builder-5338c60db17a) [to ensure a great user experience for some](https://medium.com/r/?url=https%3A%2F%2Fstevenpcurtis.medium.com%2Fuiscrollview-with-auto-layout-implemented-in-interface-builder-5338c60db17a) time.
Without using [base classes](https://medium.com/r/?url=https%3A%2F%2Fstevenpcurtis.medium.com%2Fif-youre-using-a-base-class-in-swift-you-re-doing-it-wrong-77c515f42684) or other methods to stop having to implement the `UIScrollView` in each of my views I find this rather tiresome and annoying.

I then started thinking - a `UITableView` [inherits](https://stevenpcurtis.medium.com/favor-composition-over-inheritance-in-swift-1bd91a16c392) from `UIScrollView`. What if I made all of the content for my view a cell and clip that into the `UITableView`? This would give me a scrolling view for free, and I would be able to use a `UITableViewDataSource` to manage the type of cells that would be displayed.

# The Advantages
Here's a few!
- Consistency across views, leading to consistency in testing
- Easily compatible with backend-driven development
- Small simple views that are expanded in scope don't suddenly need to be placed in a UIScrollView 
- Avoiding lots of work related to UIScrollView

# The Disadvantages
- Might not be suitable for all views (complex overlapping cells, anyone)
- Overly complex for simple views
- The separation of DataSource from View can lead to some complexity

# The Look

We have simple data for the `UITableView`  here - a heading (here displaying "Title" as the String), and a text cell. Notice the difference between the heights of the two cells in this finished screenshot:
![finished](Images/finishedsmaller.png)

# The Implementation
This code doesn't use [storyboards](https://medium.com/r/?url=https%3A%2F%2Fbetterprogramming.pub%2Favoid-storyboards-in-your-apps-8e726df43d2e), but it does use nib files for the `UITableViewCell` subclasses.

**Those `UITableViewCell` subclasses**
This particular implementation doesn't do much interesting with the the two `UITableViewCell` subclasses which are implemented, but one has the background set in a configure function:

```swift
func configure(with title: String) {
    backgroundColor = .blue
    self.textLabel?.text = title
}
```

**The ViewController**
This is a fairly standard `UIViewController` where the elements are set up programatically. Note the datasource is set to be a different class.

```swift
class ViewController: UIViewController {

    let viewModel: ViewModel
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupComponents()
        setupConstraints()
    }
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .red
        self.view = view
    }
    
    private func setupHierarchy() {
        view.addSubview(tableView)
    }
    
    private func setupComponents() {
        tableView.backgroundColor = .systemBackground
        tableView.dataSource = viewModel.dataSource
        
        let imageNib = UINib(nibName: "HeadingTableViewCell", bundle: nil)
        tableView.register(imageNib, forCellReuseIdentifier: "HeadingTableViewCell")

        let textNib = UINib(nibName: "TextTableViewCell", bundle: nil)
        tableView.register(textNib, forCellReuseIdentifier: "TextTableViewCell")
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
```

**The ViewModel**
The viewModel populates the datasource with the information to be displayed. Note that I don't like the way I've simply given Strings here and expected the datasource to know how to display these accurately in the view, but for a rather basic example I feel this is acceptable.

```swift
class ViewModel {
    let dataSource: DataSource
    
    let data: [String] = ["Title", "1", "2"]
    
    init() {
        self.dataSource = DataSource(data: data)
    }
}
```

**The DataSource**
The data source is implemented as in the code below. The general gist of this is ok, but of course the `populateTable` function only works for this particular array of input `String` so would need some work if it were to be used in a production App.

That `fatalError` might be better put into a guard, but I am happy with the implementation here with associated values.

```swift
class DataSource: NSObject, UITableViewDataSource {
    var cells: [CellType] = []
    
    enum CellType: Equatable {
        case heading(String)
        case text(String)
    }
    
    init(data: [String]) {
        super.init()
        populateTable(with: data)
    }
    
    private func populateTable(with info: [String]) {
        guard info.count == 3 else {return}
        cells.append(.heading(info[0]))
        cells.append(.text(info[1]))
        cells.append(.text(info[2]))
    }
    
    func cellType(at indexPath: IndexPath) -> CellType {
        cells[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cellType(at: indexPath) {
        case let .text(title):
            if let cell: TextTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TextTableViewCell", for: indexPath) as? TextTableViewCell {
                cell.configure(with: title)
                return cell
            }
            fatalError()
        case let .heading(title):
            if let cell: HeadingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HeadingTableViewCell", for: indexPath) as? HeadingTableViewCell {
                cell.configure(with: title)
                return cell
            }
            fatalError()
        }
    }
}
```

You do need to inherit from NSObject to ensure the table view data source methods are visible from Objective-C.

# Conclusion
This isn't an answer for all possible App contexts. It might not be the right approach for all of your views, this is completely understandable.

There is a further question - if you are going so far as to implement a UITableView in this way wouldn't you be better to implement a UICollectionView? I would say this might be an avenue for exploration, if nothing else.

In conclusion, then, this is a strategy that you might use depending on the problem you would solve. I hope this helps someone!

Subscribing to Medium using [this link](https://medium.com/r/?url=https%3A%2F%2Fstevenpcurtis.medium.com%2Fmembership) shares some revenue with me.

If you've any questions, comments or suggestions please hit me up on [Twitter](https://medium.com/r/?url=https%3A%2F%2Ftwitter.com%2Fstevenpcurtis)
