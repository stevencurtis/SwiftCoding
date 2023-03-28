# Use Inset for UITableViewCell
## Insert that inset


# Before we start
Let's take a look.
Difficulty: **Beginner** | Easy | Normal | Challenging

This article has been developed using Xcode 14.2, and Swift 5.7.2

## Prerequisites
It would be useful to know something about [UITableView](https://stevenpcurtis.medium.com/a-customuitableviewcell-in-a-uitableview-10b5893453c)

## Keywords and Terminology
ViewController: Sits between the view and the model, tying them together (usually using the delegate pattern). The controller is not tightly bound to a concrete view, and communicates via a protocol to an abstraction. An example of this is the way that a UITableView communicates with its data source through the UITableViewDataSource protocol. Think of it as the how of the App. The primary job of the controller is to format the data from the model for the view to display.
UITableView: A view that presents data using rows arranged in a single column

# Where to set
The view controller is responsible for managing data and configuring cells. The cell is responsible for displaying content and handling it's own appearance.

This means that we are going to set the insets for any particular `UITableViewCell` instances from within the owning view controller.

Let's see how that looks

# The code
This is rather simple code that displays a single table view with a cell.

```swift
class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let data = ["a", "b", "c", "d"]
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: "SubclassedTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SubclassedTableViewCell
        cell.textLabel?.text = data[indexPath.row]
        cell.leftInset = 50
        cell.rightInset = -20
        cell.bottomInset = -20
        return cell
    }
}
```

The section we are focusing on here is `cellForRowAt`.

We can set up the inserts. Let's take a look:

```swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SubclassedTableViewCell
    cell.textLabel?.text = data[indexPath.row]
    cell.leftInset = 50
    cell.rightInset = -20
    cell.bottomInset = -20
    return cell
}
```

The inserts are assigned from outside the cell.

# Conclusion
Thank you for reading.
Anyway, happy coding!

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
