# Fade the First and Last Elements in a UICollectionView
## Watch those indices

# Before we start
Difficulty: Beginner | Easy | **Normal** | Challenging<br/>
This article has been developed using Xcode 12.2, and Swift 5.3

## Prerequisites:
* You will be expected to be aware how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71) in Swift.
* Subclass `UICollectionViewCell

## Keywords and Terminology:
UICollectionView: An object that manages an ordered collection of data items and presents them using customizable layouts

# This project
## The motivation
I want to make by `UICollectionView` instances that little bit better. I want to bring the user's attention to the cell that is wholly visible on the screen.

You know what, I'll set the alpha of the cells that are not fully displayed so they look slightly washed out.

Wait, how am I going to do that?

## The Project
This project is relatively similar to a previous article of mine about subclassing `UICollectionViewCell`, and you might want to go back to look at that one if you find this article a little challenging. 

The `UICollectionViewCell` is a subclass that simply has a `UIImageView` displayed

```swift
class SubclassedCollectionViewCell: UICollectionViewCell {
    // the hotel is lazyly instantiated in a UIImageView
    var hotelImageView: UIImageView = {
        var hotelView = UIImageView()
        hotelView.contentMode = .scaleAspectFill
        hotelView.clipsToBounds = true
        return hotelView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // add the imageview to the UICollectionView
        addSubview(hotelImageView)
        // we are taking care of the constraints
        hotelImageView.translatesAutoresizingMaskIntoConstraints = false
        // pin the image to the whole collectionview
        hotelImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        hotelImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        hotelImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        hotelImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(image: String) {
        // set the appropriate image
        if let image : UIImage = UIImage(named: image) {
            hotelImageView.image = image
        }
    }
    
    func updateCell(faded: Bool, animated: Bool = true) {
        // if you want the opacity animated
        if animated {
            // animate with the duration in seconds
            UIView.animate(withDuration: 0.2) {
                // if it is faded, fade out to 0.1 opacity. If not, make clear at 1.0 opacity
                self.alpha = faded ? 0.1 : 1.0

            }
        } else {
            // if it is faded, fade out to 0.1 opacity. If not, make clear at 1.0 opacity
            self.alpha = faded ? 0.1 : 1.0
        }
    }
}
```

Now update cell will be called, and I've taken the liberty to make the washed out look fade out and in using [an animation](https://stevenpcurtis.medium.com/master-uiview-animation-ac21ebf42589), which is called by a rather friendly looking updateCell function.

## The Theory
This project will use `optional func scrollViewDidScroll(_ scrollView: UIScrollView)` which is used when the user scrolls the `UICollectionView` instance. Now this works, since `UICollectionView` inherits fom `UIScrollview` so the implementation just needs to be put in the `UIViewController` subclass that is the delegate for you `UICollectionView` - so no problem there.

In fact the meat and bones of this project are as follows;

```swift
func scrollViewDidScroll(_ scrollView: UIScrollView) {
    // the visible cells are returned, and sorted into order
    let visibleCells = self.collectionView.indexPathsForVisibleItems
        .sorted { top, bottom -> Bool in
            return top.section < bottom.section || top.row < bottom.row
        }.compactMap { indexPath -> UICollectionViewCell? in
            return self.collectionView.cellForItem(at: indexPath)
        }
    // the indexpaths of the visible cells are sorted into order
    let indexPaths = self.collectionView.indexPathsForVisibleItems.sorted()
    // a property containing the number of visible cells
    let cellCount = visibleCells.count
    // if we don't have a first cell, we don't have any cells and there isn't anything to do
    guard let firstCell = visibleCells.first as? SubclassedCollectionViewCell, let firstIndex = indexPaths.first else {return}
    // check if the first cell is visible
    checkVisibilityOfCell(cell: firstCell, indexPath: firstIndex)
    if cellCount == 1 {return}
    // if we don't have a last cell, there is only one so we don't have more to do
    guard let lastCell = visibleCells.last as? SubclassedCollectionViewCell, let lastIndex = indexPaths.last else {return}
    // check if the last cell is visible
    checkVisibilityOfCell(cell: lastCell, indexPath: lastIndex)
}

func checkVisibilityOfCell(cell: SubclassedCollectionViewCell, indexPath: IndexPath) {
    // compute the frame of the cell
    if let cellRect = (collectionView.layoutAttributesForItem(at: indexPath)?.frame) {
        // it is visible iff the bounds of the cell are contained wholly in collectionview
        let completelyVisible = collectionView.bounds.contains(cellRect)
        // update the cell accordingly
        cell.updateCell(faded: !completelyVisible)
    }
}
```

So we can access the visible cells through the property on the `UICollectionView` instance through `self.collectionView.indexPathsForVisibleItem`, and likewise the indexes through `self.collectionView.indexPathsForVisibleItems` - we do need to sort both of these through because we cannot guarentee the order that they will be returned to us in.

## The Code
The code for the subclassed `UICollectionViewCell` is above, and the code for the `UIViewController` instance is below. Of course I've used 8 photos of hotels (you might like to download those from my REPO), but you can replace them with your own as I have added those as 1-8 in my asset catalogue (so you would do the same with your own images). You can see the attribution for these images below:

```swift
class ViewController: UIViewController {
    var data = ["1","2","3","4","5","6","7","8","1","2","3","4","5","6","7","8"]

    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // set the data source to be ViewController
        self.collectionView.dataSource = self
        // set the delegate to be the ViewController
        self.collectionView.delegate = self
        // register SubclassedCollectionViewCell
        self.collectionView.register(SubclassedCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        // bouncing occurs when we reach the end of the UICollectionViewCells
        self.collectionView.alwaysBounceVertical = true
        // set the background of the collection view
        self.collectionView.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // call super of viewDidAppear
        super.viewDidAppear(animated)
        // Get an array of visible cells
        let visibleCells = collectionView.visibleCells
        // cells are visible unless...
        for i in 0..<visibleCells.count - 1 {
            // only SubclassedCollectionViewCell instances have updateCell
            if let myCell = visibleCells[i] as? SubclassedCollectionViewCell {
                myCell.updateCell(faded: false, animated: false)
            }
        }
        // it is the last cell, which is faded
        (visibleCells[visibleCells.count - 1] as! SubclassedCollectionViewCell).updateCell(faded: true, animated: false)
    }

    override func loadView() {
        // set up a UICollectionViewFlowLayout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        // with a set item size
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 20, height: UIScreen.main.bounds.size.width / 2)
        // which scrolls vertically
        layout.scrollDirection = .vertical
        // setup the collectionview
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        // set the view as the collectionView
        self.view = collectionView
    }

    
    /// called when the user scrolls the scrollview (in this case a UICollectionView)
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // the visible cells are returned, and sorted into order
        let visibleCells = self.collectionView.indexPathsForVisibleItems
            .sorted { top, bottom -> Bool in
                return top.section < bottom.section || top.row < bottom.row
            }.compactMap { indexPath -> UICollectionViewCell? in
                return self.collectionView.cellForItem(at: indexPath)
            }
        // the indexpaths of the visible cells are sorted into order
        let indexPaths = self.collectionView.indexPathsForVisibleItems.sorted()
        // a property containing the number of visible cells
        let cellCount = visibleCells.count
        // if we don't have a first cell, we don't have any cells and there isn't anything to do
        guard let firstCell = visibleCells.first as? SubclassedCollectionViewCell, let firstIndex = indexPaths.first else {return}
        // check if the first cell is visible
        checkVisibilityOfCell(cell: firstCell, indexPath: firstIndex)
        if cellCount == 1 {return}
        // if we don't have a last cell, there is only one so we don't have more to do
        guard let lastCell = visibleCells.last as? SubclassedCollectionViewCell, let lastIndex = indexPaths.last else {return}
        // check if the last cell is visible
        checkVisibilityOfCell(cell: lastCell, indexPath: lastIndex)
    }
    
    /// check the visibility of the SubclassedCollectionViewCell
    func checkVisibilityOfCell(cell: SubclassedCollectionViewCell, indexPath: IndexPath) {
        // compute the frame of the cell
        if let cellRect = (collectionView.layoutAttributesForItem(at: indexPath)?.frame) {
            // it is visible iff the bounds of the cell are contained wholly in collectionview
            let completelyVisible = collectionView.bounds.contains(cellRect)
            // update the cell accordingly
            cell.updateCell(faded: !completelyVisible)
        }
    }
}

extension ViewController: UICollectionViewDelegate {
    // out of the scope of this tutorial, we just print the index if that cell is selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
}

extension ViewController: UICollectionViewDataSource {
    // out of the scope of this tutorial, we will access the number of items in the data array
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    // out of the scope of this tutorial, we dequeue the cell and setup the data in that cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SubclassedCollectionViewCell {
            let data = self.data[indexPath.item]
            cell.setupCell(image: data)
            return cell
        }
        fatalError("Could not dequeue cell")
    }
}
```

# Credits
This article uses the images by the following:
Photo by Boxed Water Is Better on Unsplash
Photo by Rhema Kallianpur on Unsplash
Photo by Edvin Johansson on Unsplash
Photo by Alexander Kaunas on Unsplash
Photo by Markus Spiske on Unsplash
Photo by Manuel Moreno on Unsplash
Photo by Crew on Unsplash
Photo by Eunice Stahl on Unsplash

# Conclusion
Knowing something about `func convert(_ rect: CGRect, to view: UIView?) -> CGRect` and `var indexPathsForVisibleItems: [IndexPath] { get }` would have got you to this answer.

Yet not everybody knows each and every function and property on `UICollectionView`, I know - but this tutorial has helped you out with this particular set of challenges and I hope has helped you out in your coding journey.

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
