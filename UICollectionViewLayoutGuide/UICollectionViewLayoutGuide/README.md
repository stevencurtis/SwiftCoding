# UICollectionViewLayoutGuide for Swift iOS Apps
## Use UICollectionView properly

Difficulty: Beginner | Easy | **Normal** | Challenging<br/>
This article has been developed using Xcode 12.5, and Swift 5.4

# Prerequisites:
* You will be expected to be aware of how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71)

# Terminology
UICollectionViewLayoutGuide: A type of layout object that is used in conjunction with a collection view layout to define the placement and sizing of supplementary views and decoration views within the collection view
UICollectionViewLayerAttributes: A layout object that manages the layout-related attributes for a given item in a collection view
UICollectionViewFlowLayout: A layout object that organizes items into a grid with optional header and footer views for each section
UICollectionViewCell: The on-screen cell for the UICollectionView type
UICollectionViewLayout: An abstract base class for generating layout information for a collection view


# Implement a UICollectionView
We are going to implement `UICollectionView` where we can scroll vertically or horizontally, and view several `UICollectionViewCell` items. 
[Images/img2.png](Images/img2.png)<br>

# UICollectionViewFlowLayout and UICollectionViewLayout
## Wait, What is the difference between UICollectionViewFlowLayout and UICollectionViewLayout
`UICollectionFlowLayout` is the usual type of flow layout that might be used, and implements a grid-based layout through the class [https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout), whereas UICollectionViewLayout is an abstract base class for generating the layout of a collectionview [https://developer.apple.com/documentation/uikit/uicollectionviewlayout](https://developer.apple.com/documentation/uikit/uicollectionviewlayout).

Now before going all the way to a `UICollectionViewLayout` Apple recommend you use a [compositional layout](https://stevenpcurtis.medium.com/create-the-app-store-with-uicollectionview-compositional-layouts-85e62b85229f), so I've provided a link to a rather nice article for just that.

# The BasicUICollectionViewController
The most basic `UICollectionViewController` still needs a layout. So we are going to use the most basic possible `UICollectionViewFlowLayout()`.

Now in order to do this we implement functions from `UICollectionViewDataSource` and `UICollectionViewDelegate`.

[Images/img1.png](Images/img1.png)<br>

As shown in that diagram, we are displaying data formatted as a grid. We therefore need to implement the data source and delegate. Here is the implementation to do just that:

```swift
final class BasicUICollectionViewController: UIViewController {
    enum Constants {
        static let reuseCell = "subclassedcell"
    }
    
    var collectionView: UICollectionView!
    let viewModel: BasicUICollectionViewModel
    
    override func loadView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        self.view = collectionView
    }

    init(viewModel: BasicUICollectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(SubclassedCollectionViewCell.self, forCellWithReuseIdentifier: Constants.reuseCell)
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.backgroundColor = .white
    }
}

extension BasicUICollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at CollectionView \(collectionView.tag) selected index path \(indexPath)")
    }
}

extension BasicUICollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseCell, for: indexPath) as? SubclassedCollectionViewCell {
            let data = viewModel.data[indexPath.item]
            cell.setupCell(colour: data)
            return cell
        }
        fatalError("Unable to dequeue subclassed cell")
    }
}
```

this accesses the most basic possible view model:

```swift
final class BasicUICollectionViewModel {
    var data = [UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green, UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green, UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green, UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.systemPink, UIColor.green, UIColor.blue, UIColor.green, UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green, UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.systemPink]
}
```

# The BasicFlowLayoutViewController; conforming to the protocol
The secret sauce here is that we conform to `UICollectionViewDelegateFlowLayout`. The functions are optional, but to make this more interesting I decided to restrict this to 2 cells in a row. Oh yes, and have a more than one section as well:

[Images/img3.png](Images/img3.png)<br>

Notice as well we add complexity by adding headers through `viewForSupplementaryElementOfKind`.

The basic conformance to the protocol is shown as follows:

```swift
extension BasicFlowLayoutViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 100, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 2
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow)) - 20
        return CGSize(width: size, height: size)
    }
}
```

Which is a part of the following `UIViewController`:

```swift
class BasicFlowLayoutViewController: UIViewController {
    enum Constants {
        static let reuseCell = "subclassedcell"
        static let reuseHeader = "header"
    }
    
    override func loadView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        self.view = collectionView
    }
    
    var collectionView: UICollectionView!
    let viewModel: BasicFlowLayoutViewModel
    
    init(viewModel: BasicFlowLayoutViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(SubclassedCollectionViewCell.self, forCellWithReuseIdentifier: Constants.reuseCell)
        self.collectionView?.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constants.reuseHeader)
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.backgroundColor = .white
    }
}

extension BasicFlowLayoutViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at CollectionView \(collectionView.tag) selected index path \(indexPath)")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.size.width, height: 123)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.reuseHeader, for: indexPath) as? HeaderView {
            headerView.title.text = "Section \(indexPath.section)"
            return headerView
        }
        fatalError("Could not dequeVuew")
    }
}

extension BasicFlowLayoutViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 100, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 2
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow)) - 20
        return CGSize(width: size, height: size)
    }
}

extension BasicFlowLayoutViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.sectionAdata.count
        }
        return viewModel.sectionBdata.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subclassedcell", for: indexPath) as? SubclassedCollectionViewCell {

            let data: UIColor
            if indexPath.section == 0 {
                data = viewModel.sectionAdata[indexPath.item]
            }
            else {
                data = viewModel.sectionBdata[indexPath.item]
            }
            cell.setupCell(colour: data)
            return cell
        }
        fatalError("Unable to dequeue subclassed cell")
    }
}
```

Of course this demands a slightly more complex view model

```swift
class BasicFlowLayoutViewModel {
    var sectionAdata = [UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green, UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.systemPink]
    
    var sectionBdata = [UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green, UIColor.red, UIColor.green, UIColor.blue, UIColor.green]
}
```

# The CollectionViewLayout against UICollectionViewFlowLayout explanation mk2
To create advanced layouts (that is, more than the gird above) you can create a custom layout subclass. One of these is a fading layout, which is a `UICollectionViewLayout` subclass. 

I've already written a hole example using this one: https://stevenpcurtis.medium.com/fade-the-first-and-last-elements-in-a-uicollectionview-3fc2cdfb0f46.
It's not a magic pill though. `UICollectionView` provides a way of calculating the position of CollectionView's child cells.
Since `UICollectionViewFlowLayout` is a concrete class of `UICollectionViewLayout` that has all its four members implemented, it's easier to use (depending on what you want to do!) than `UICollectionViewLayout`. It automatically specifies that the cells will be arranged in a grid manner.

# Conclusion

I hope this article has been of help to you.
I guess I'll see you next time?

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis)
