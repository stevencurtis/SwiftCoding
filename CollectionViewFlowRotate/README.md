# Use UICollectionViewFlowLayout and Let It Rotate!
## Going around

# Before we start
Difficulty: Beginner | Easy | **Normal** | Challenging<br/>

## Keywords and Terminology:
UICollectionView: An object that manages an ordered collection of data items and presents them using customizable layouts
UICollectionViewCell: The on-screen cell for the UICollectionView type
UICollectionViewFlowLayout: A layout object that organizes items into a grid with optional header and footer views for each section
//

Rather than having a simple grid where you use `UICollectionViewFlowLayout` alone, you can subclass `UICollectionViewLayout` to make a more sophisticated layout.

This article helps you to create the most simple `UICollectionViewFlowLayout` programatically, and uses explicitly defining cell sizes so this is something to build on for more complex layouts.

# Why
Apple have given us the standard `UICollectionViewFlowLayout`, and this works fantastically for most uses of `UICollectionView` where grids are needed. 

This might be done (in the example code this is in `loadView` by using the following code:

```swift
let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
layout.itemSize = CGSize(width: 60, height: 60)
layout.scrollDirection = .horizontal
```

but it is, unfortunately limited. On the other hand subclassing `UICollectionViewFlowLayout` can be tricky. In order to bridge the gap, in steps this article.

# The Theory
When we subclass `UICollectionViewLayout` we are subclassing an abstract class, and there are number of functions that we are going to override:

`collectionViewContentSize`
Information about the size of the collection view's contents. This is not just the visible contents, but the whole content - so we know where we are going to scroll to.

`prepare:`
Called every time the layout operation is going to take place, and performs the calculations for the UICollectionView's size and position of the items.

`layoutAtttributesForElements(in:)`
Returns the attributes for all cells and supplementary views, which intersect the specified rectangle called by the system.

`LayoutAttributesForItem(at:)`
Not in this article, this returns the layout attributes for a specific item.

`invalidateLayout(with context)`
Called when we change the orientation, in this example a good place to clear the cache

# The Implementation
The general implementation of this is programmatic, and that means there isn't any storyboard in the repo. Is that OK?

## The ViewController
Here the `UICollectionView` and the `CustomLayout` are set up. Incidentally, a custom subclass `UICollectionViewCell` has also been used (this makes the following code suitable for more complex code in the future!)

```swift
class ViewController: UIViewController{
    // lots of colours for our collectionview
    var data = [UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green, UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green, UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green, UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.systemPink]
    
    // the UICollectionView
    var collectionView: UICollectionView!

    // settings in viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // set the dataSource
        self.collectionView.dataSource = self
        // set the delegate
        self.collectionView.delegate = self
        // register the UICollectionViewCell
        self.collectionView.register(SubclassedCollectionViewCell.self, forCellWithReuseIdentifier: "subclassedcell")
        // bounce when we reach the end of the contentview
        self.collectionView.alwaysBounceVertical = true
        // set the background color of the UICollectionView
        self.collectionView.backgroundColor = .white
    }
    
    override func loadView() {
        // set the layout as the CustomLayout
        let layout = CustomLayout()
        // Set the frame of the UICollectionView
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        // set the whole view as the collectionview
        self.view = collectionView
    }
}

extension ViewController: UICollectionViewDelegate {
    // a delegate function to be run when the UICollectionView is written
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // print the information tot he console
        print("Collection view at CollectionView \(collectionView.tag) selected index path \(indexPath)")
    }
}

extension ViewController: UICollectionViewDataSource {
    // How many items are there in a section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // there are as many items as in the data array
        data.count
    }
    
    // return a cell for each and every UICollectionViewCell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // attempt to dequeueResuableCell as SubclassedCollectionViewCell
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subclassedcell", for: indexPath) as? SubclassedCollectionViewCell {
            // data is from the data array
            let data = self.data[indexPath.item]
            // setup the cell with the colour
            cell.setupCell(colour: data)
            // return the cell
            return cell
        }
        // if we can't dequque then something has gone terribly wrong, so we can fatalcrash
        fatalError("Unable to dequeue subclassed cell")
    }
}
```

## The SubclassedCollectionViewCell
This is a simple cell, which only really implements the background colour of the cell.
```swift
class SubclassedCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(colour: UIColor) {
        self.backgroundColor = colour
    }
}
```

## The CustomLayout
As shown in the theory above, this code has been designed to be as readable as possible. Perhaps unfortunately, I've added comments to each and every line. Does that help you? I hope so.
```swift
class CustomLayout: UICollectionViewFlowLayout {
    // the cache store so we don't have to keep calcuating the attributes
    var cache = [UICollectionViewLayoutAttributes]()
    // this is the content bounds for the area of the content
    var contentBounds = CGRect.zero

    override func invalidateLayout(with context: UICollectionViewLayoutInvalidationContext) {
        super.invalidateLayout(with: context)
        // when we rotate, clear the cached data
        cache = []
    }
    
    // the size of the content (without which we cannot scroll)
    override var collectionViewContentSize: CGSize {
        return contentBounds.size
    }
    
    // update the current layout, setting the frame for each cell and store in a cache
    // prepare up-front calculations to provide layout information
    // whenever the layout is invalidated, preparelayout is called
    override func prepare() {
        super.prepare()
        // don't recalculate everything if we haven't cleared our cache (so we are on the same orientation)
         guard self.cache.isEmpty, let collectionView = collectionView else {
             return
         }
        
        // set the contentBounds to be the size of the collectionview, pinned at the top-left
        contentBounds = CGRect(origin: .zero, size: collectionView.bounds.size)

        // we need to know the last frame in order to sequentially show the UICollectionViewCells
        var lastFrame: CGRect = .zero
        
        // for each item in the UICollectionView
        for item in 0..<collectionView.numberOfItems(inSection: 0){
            // the frame will be calculated from the last frame, with a height of 200
            let frame = CGRect(x: 0, y: lastFrame.maxY, width: collectionView.bounds.width, height: 200.0)
            // calculate the indexPath
            let indexPath = IndexPath(item: item, section: 0)
            // we are going to deal with the attributes for the current index path
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            // set the frame of the attribute, which is for the current indexPath
            attributes.frame = frame
            // make sure we have a cache so we don't always recreate the same attributes
            cache.append(attributes)
            // set the last frame
            lastFrame = frame
            // calculate the bounds of the whole content
            contentBounds = contentBounds.union(lastFrame)
        }
    }
    
    // This method returns the attributes for every cell in a rectangle
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        // Loop through the cache and look for items in the rect
        for attributes in cache {
            // if the attributes insect the given CGRect
            if attributes.frame.intersects(rect) {
                // we are interested in these attributes! So we can prepare to return them!
                visibleLayoutAttributes.append(attributes)
            }
        }
        // return the attributes
        return visibleLayoutAttributes
    }
}
```

# Conclusion
If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis)
