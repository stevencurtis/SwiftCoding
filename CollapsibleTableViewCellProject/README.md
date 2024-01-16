# Creating a collapsible UITableViewCell in Swift: A Step-by-Step Guide
## Appear that section!

Difficulty: Beginner | **Easy** | Normal | Challenging<br/>
This article has been developed using Xcode 15.0, and Swift 5.9

The background to this is I wanted to make an email from a SwiftUI App. I mean how hard can that be?

## Prerequisites:
You need to be able to code in Swift, using UIKit.

# The Project
I've been thinking about creating a social media style application.

[Images/finishedsmall.png](Images/finishedsmall.png)<br>

It's a rather basic `UITableView` with requisite `UITableViewCell` instances. When you click on the cell the like count is incremented. Something like the following

[Images/Recording.mp4](Images/Recording.mp4)<br>

Which should be pretty easy.

## No data
There is no backend for this. So what I'm going to do is make some `CellData`.

```swift
struct CellData {
    var count: Int
    var expanded: Bool
}
```

That's a rather simple struct. Note that I'm storing the 'likeCount' as a var to store the number of likes. Potentially this would be indicated from a backend service, so in my example I simply initiate the likes to zero.

```swift
private lazy var data = makeData()

private func makeData() -> [CellData] {
    var data: [CellData] = []
    for _ in 0..<20 {
        let cellData = CellData(
            likeCount: 0,
            expanded: false
        )
        data.append(cellData)
    }
    return data
}
```

Is this the right place to store the number of likes? Sure, it's the single store of truth for the likes from the BE added to the number of likes that the user may have given for a particular cell. It's actually the same here for the state of the cell, if it's expanded or not is stored as a `Boolean` in this object.

When the user clicks on a cell the `UITableViewCell` will expand. I'm going to do so by making the relevant view `isHidden` or not, depending on the state of the cell.

## Expanding
Here is my `CollapsibleCell` which is a `UITableViewCell` subclass. I've created this programmatically (sorry for that). I've used property injection for the `onButtonClicked` closure and the count (sorry for that). When the `count` is updated the `UILabel` is updated on the cell too.

```swift
final class CollapsibleCell: UITableViewCell {
    private let counterLabel = UILabel()
    private let button = UIButton()
    private let stackView = UIStackView()
    var onButtonClicked: (() -> Void)?
    var count = 0
    {
        didSet {
            counterLabel.text = "Like count: \(count.description)"
        }
    }
    
    let expandableView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setup() {
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 8,
            leading: 16,
            bottom: 8, 
            trailing: 16
        )
        contentView.addSubview(stackView)
        counterLabel.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Press to like", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(
            self,
            action: #selector(buttonClicked),
            for: .touchUpInside
        )
        stackView.addArrangedSubview(button)
        stackView.addArrangedSubview(expandableView)
        expandableView.addSubview(counterLabel)
        expandableView.isHidden = true
        contentView.addSubview(stackView)
        setConstraints()
    }

    @objc private func buttonClicked() {
        onButtonClicked?()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            counterLabel.topAnchor.constraint(equalTo: expandableView.topAnchor),
            counterLabel.bottomAnchor.constraint(equalTo: expandableView.bottomAnchor),
            counterLabel.leadingAnchor.constraint(equalTo: expandableView.leadingAnchor),
            counterLabel.trailingAnchor.constraint(equalTo: expandableView.trailingAnchor)
        ])
    }
}
```

So the expanded property needs to be set somewhere. I'm doing this in the delegate `cellForRowAt` function.

```swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellReuseIdentifier) as? CollapsibleCell else {
        debugPrint("Error: Unable to dequeue cell")
        return UITableViewCell()
    }
    cell.selectionStyle = .none
    let cellData = data[indexPath.row]
    cell.expandableView.isHidden = !cellData.expanded
    cell.count = cellData.likeCount
    cell.onButtonClicked = { [weak self] in
        self?.updateData(with: indexPath)
    }

    return cell
}
```

so when we click on the cell the closure will be called. The function is called `updateData(with indexPath:)` that I've developed in the `UIViewController`.

```swift
private func updateData(with indexPath: IndexPath) {
    data[indexPath.row].expanded = true
    data[indexPath.row].likeCount += 1
    tableView.reloadRows(at: [indexPath], with: .automatic)
}
```

`tableView.reloadRows(at:with)` is more efficient than reloading the entire `UITableView` and also provides us with an `UITableView.RowAnimation` so it will all look nice too!

# The full code
In Swift here is the entire code.

```swift
import UIKit

final class CollapsibleTableCellViewController: UIViewController {
    struct CellData {
        var likeCount: Int
        var expanded: Bool
    }
    private lazy var tableView = UITableView()
    private lazy var data = makeData()

    private func makeData() -> [CellData] {
        var data: [CellData] = []
        for _ in 0..<20 {
            let cellData = CellData(
                likeCount: 0,
                expanded: false
            )
            data.append(cellData)
        }
        return data
    }
    
    private func updateData(with indexPath: IndexPath) {
        data[indexPath.row].expanded = true
        data[indexPath.row].likeCount += 1
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    private enum Constants {
        static let cellReuseIdentifier = "cell"
        static let estimatedRowHeight: CGFloat = 100
        static let postsTableViewAccessibilityIdentifier = "PostsTableView"
        static let postLabelAccessibilityIdentifier = "PostLabel"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupComponents()
        setupConstraints()
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemBackground
        self.view = view
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        view.addSubview(tableView)
    }
    
    private func setupComponents() {
        tableView.register(
            CollapsibleCell.self,
            forCellReuseIdentifier: Constants.cellReuseIdentifier
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Constants.estimatedRowHeight
        tableView.accessibilityIdentifier = Constants.postsTableViewAccessibilityIdentifier
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ]
        )
    }
}

extension CollapsibleTableCellViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellReuseIdentifier) as? CollapsibleCell else {
            debugPrint("Error: Unable to dequeue cell")
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        let cellData = data[indexPath.row]
        cell.expandableView.isHidden = !cellData.expanded
        cell.count = cellData.likeCount
        cell.onButtonClicked = { [weak self] in
            self?.updateData(with: indexPath)
        }

        return cell
    }
}

extension CollapsibleTableCellViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

final class CollapsibleCell: UITableViewCell {
    private let counterLabel = UILabel()
    private let button = UIButton()
    private let stackView = UIStackView()
    var onButtonClicked: (() -> Void)?
    var count = 0
    {
        didSet {
            counterLabel.text = "Like count: \(count.description)"
        }
    }
    
    let expandableView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setup() {
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 8,
            leading: 16,
            bottom: 8, 
            trailing: 16
        )
        contentView.addSubview(stackView)
        counterLabel.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Press to like", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(
            self,
            action: #selector(buttonClicked),
            for: .touchUpInside
        )
        stackView.addArrangedSubview(button)
        stackView.addArrangedSubview(expandableView)
        expandableView.addSubview(counterLabel)
        expandableView.isHidden = true
        contentView.addSubview(stackView)
        setConstraints()
    }

    @objc private func buttonClicked() {
        onButtonClicked?()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            counterLabel.topAnchor.constraint(equalTo: expandableView.topAnchor),
            counterLabel.bottomAnchor.constraint(equalTo: expandableView.bottomAnchor),
            counterLabel.leadingAnchor.constraint(equalTo: expandableView.leadingAnchor),
            counterLabel.trailingAnchor.constraint(equalTo: expandableView.trailingAnchor)
        ])
    }
}
```

That should work in order to have that expending cell. Of course it's easier if the code is available for anyone to see, so I've pushed in up to my repo. I hope that helps. [https://github.com/stevencurtis/SwiftCoding/tree/master/CollapsibleTableViewCellProject](https://github.com/stevencurtis/SwiftCoding/tree/master/CollapsibleTableViewCellProject)<br>

# Conclusion
If you've got any comments I'd love to hear them. Anyway this is how I might implement a component library and I hope you enjoyed reading this.
