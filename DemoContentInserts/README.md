# Mastering UITableView Content
## When, why and how

UITable view is a fundamental iOS component, but managing it can be tricky.

Dealing with extra spacing, floating buttons and ensuring content isn't covered by UI elements can be challenging. 

One of the tools in our development toolkit is `contentInset` and I'll cover that in this article.


I'll put a demo project on
https://github.com/stevencurtis/SwiftCoding/tree/master/DemoContentInserts, and I hope that helps things for you too.

# Understanding contentInset

The `contentInset` property of `UIScrollView` (which `UITableView` inherits) allows you to add extra padding around the scrollable content without affecting the table’s constraints.

Example:

```swift
tableView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
```

Ensures that the content starts *lower* than the default position (the top inset).

In the following image the background of the `UITableView` is set to `.green` so you can see the inset at the top of the `UITableView`. 

The thing is you wouldn't usually be able to see that inset at the top of the table unless you scroll to see it. If you *initially* want the inset to be shown at the top of the `UITableView` you'll need to scroll the table to be able to see it. That requires setting the point for the origin of the content view, as offset from the origin of the scrollview.

Which is done with something like the following:

```swift
tableView.contentOffset = CGPoint(x: 0, y: -100)
```

<img src="https://github.com/stevencurtis/SwiftCoding/tree/master/DemoContentInserts" width="400">

## A Practical Example:

Let’s say we have a table view with a floating button at the bottom. If we don’t adjust `contentInset.bottom`, the last row might be covered by the button.

```swift
final class ContentViewModel {
    var data = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"]
}

final class ContentViewController: UIViewController {
    private let viewModel: ContentViewModel

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.rowHeight = 44
        tableView.backgroundColor = .green
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private lazy var floatingButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 30
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    init(viewModel: ContentViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .orange
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(floatingButton)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            // Floating Button Constraints
            floatingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            floatingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            floatingButton.widthAnchor.constraint(equalToConstant: 60),
            floatingButton.heightAnchor.constraint(equalToConstant: 60)
        ])

        tableView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 100, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -100)
    }
}

// MARK: - UITableViewDataSource
extension ContentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.data[indexPath.row]
        return cell
    }
}
```
✅ contentInset.top = 100 leaves space at the top, allowing the green background to be visible.
✅ contentInset.bottom = 100 ensures the last row doesn’t get covered by the floating button.
✅ The floating button remains in a fixed position, while the table scrolls naturally.

# contentInset.bottom vs. tableFooterView

A common mistake developers make is assuming that `tableFooterView` can be used in place of contentInset.bottom. However, they serve different purposes.

`contentInset.bottom` adds a scrollable space at the bottom of a table, and if often used to prevent the last row from being hidden.

`tableFooterView` on the other hand is just an extra view and is good for creating footers with labels, loaders and so on.

# Conclusion

`contentInset` is an essential tool when working with `UITableView`. Whether you're ensuring visibility of UI elements, making scrolling feel more natural, or adding extra space for user interaction, understanding how to properly use `contentInset.top` and `contentInset.bottom` will significantly improve your UI design.

Next time you're working with `UITableView`, ask yourself:

Do I need extra space at the top for better visual separation?

Is the last row getting covered by another UI element?

Should I use tableFooterView, or do I need contentInset.bottom?

Mastering these concepts will make your interfaces smoother and more user-friendly! 🚀
