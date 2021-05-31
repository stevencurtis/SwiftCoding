# Create a UICollectionView programmatically
## Wholly programatically?

![photo-1546914782-96b636ea44e5](Images/photo-1546914782-96b636ea44e5.jpeg)
<sub>Photo by Susan Duran</sub>

Difficulty: **Beginner** | Easy | Normal | Challenging<br/>
This article has been developed using Xcode 12.1, and Swift 5.3

## Prerequisites:
* You will be expected to be aware how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71) in Swift.

## Terminology
Subclassing: This is the act of basing a new class on an existing class
UICollectionView: An object that manages an ordered collection of data items and presents them using customizable layouts

## The project
This article will run through creating a `UICollectionView` programatically, with one version using a `UICollectionViewCell` and one using a subclassed `UICollectionViewCell` called  `SubclassedCollectionViewCell`.

## A Menu
This isn't entirely part of this guide, however we will still look into the working of the menu (or at least have the code here!).

The menu will help the user choose between a view controller using the standard `UICollectionViewCell`, and one that uses a subclassed cell called `SubclassedCollectionViewCell`.

We will need to delete the Storyboard, and remove the reference from the project and the plist. The whole process is described in the following [guide](https://medium.com/@stevenpcurtis.sc/write-clean-code-by-overriding-loadview-ac4f172163d0), and then to instantiate the view controller is implemented in the `SceneDelegate` class as follows:

```swift
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        self.window = UIWindow(windowScene: windowScene)

        let vc = MenuViewController()

        let rootNC = UINavigationController(rootViewController: vc)

        self.window?.rootViewController = rootNC
        self.window?.makeKeyAndVisible()
    }
```

and for completion's sake, here is the `MenuViewController`:

```swift
class MenuViewController: UIViewController {
    override func loadView() {
        let view = UIView()
        self.view = view
        self.view.backgroundColor = .blue
    }
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.addArrangedSubview(plainViewControllerButton)
        sv.addArrangedSubview(subclassedViewButton)
        return sv
    }()
    
    lazy var plainViewControllerButton: UIButton = {
       let bt = UIButton()
        bt.setTitle("Plain ViewController", for: .normal)
        bt.addTarget(self, action: #selector(goPlain), for: .touchDown)
        return bt
    }()
    
    lazy var subclassedViewButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("Subclassed ViewController", for: .normal)
        bt.addTarget(self, action: #selector(goSubclass), for: .touchDown)
        return bt
    }()
    
    @objc func goPlain() {
        self.navigationController?.pushViewController(ViewController(), animated: true)
    }
    
    @objc func goSubclass() {
        self.navigationController?.pushViewController(ViewControllerSubClassedCell(), animated: true)
    }

    func addConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    override func viewDidLoad() {
        view.addSubview(stackView)
        addConstraints()
    }
}
```

## Commonalities between the two view controllers
We are simply going to display a set of colours. Here are those colours, in an array called data:

```swift
var data = [UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green, UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green, UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green, UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green]
```

in each implementation we will use a `loadView()`  to setup the views:

```swift
override func loadView() {
    // create a layout to be used
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    // make sure that there is a slightly larger gap at the top of each row
    layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
    // set a standard item size of 60 * 60
    layout.itemSize = CGSize(width: 60, height: 60)
    // the layout scrolls horizontally
    layout.scrollDirection = .horizontal
    // set the frame and layout
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    // set the view to be this UICollectionView
    self.view = collectionView
}
```
we will hold a property in each implementation for the collectionview:

```swift
var collectionView: UICollectionView!
```

while `viewDidLoad()` will setup those properties of the `UICollectionView`:

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    // set the dataSource
    self.collectionView.dataSource = self
    // set the delegate
    self.collectionView.delegate = self
    // bounce at the bottom of the collection view
    self.collectionView.alwaysBounceVertical = true
    // set the background to be white
    self.collectionView.backgroundColor = .white
}
```

each implementation will respond if the user clicks a cell:

```swift
extension ViewController: UICollectionViewDelegate {
    // if the user clicks on a cell, display a message
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
}
```

We then turn to conforming to `UICollectionViewDataSource` (which both implementations will do) and make the `numberOfItemsInSection` wholly dependent on the number of colours in the array

```swift
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // the number of cells are wholly dependent on the number of colours
    data.count
}
```

## A ViewController using the `UICollectionViewCell`
Here, we can think of our implementation as using a standard `UICollectionViewCell`. In this case we register the cell within the `viewDidLoad()` method:

```swift
self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
```

Then, while  conforming to `UICollectionViewDataSource` we implement `cellForItemAt` and return the cell. Note that we set the cell's background colour from outside the cell's implementation, something we have to do when we are using the standard `UICollectionCell` implementation.

```swift
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    // dequeue the standard cell
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    let data = self.data[indexPath.item]
    cell.backgroundColor = data
    return cell
}
```

## A ViewController using a subclassed `UICollectionViewCell`
Here we are going to use our own implementation of the a `UICollectionViewCell`. This looks something like the following:

```swift
class SubclassedCollectionViewCell: UICollectionViewCell {
    // must call super
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // we have to implement this initializer, but will only ever use this class programmatically
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(colour: UIColor) {
        self.backgroundColor = colour
    }
}
```

note that this uses ideas around [initialization](https://medium.com/@stevenpcurtis.sc/swift-initializers-fc12908a9106).

We will then register this class from our `UIViewController` instance that sets up the `UICollectionView` for the subclassed cell. I've called this `ViewControllerSubClassedCell` and the following line belongs in `viewDidLoad()`

```swift
self.collectionView.register(SubclassedCollectionViewCell.self, forCellWithReuseIdentifier: "subclassedcell")
```

which is then dequeued from `cellForItemAt`

```swift
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subclassedcell", for: indexPath) as? SubclassedCollectionViewCell {
        let data = self.data[indexPath.item]
        cell.setupCell(colour: data)
        return cell
    }
    fatalError("Unable to dequeue subclassed cell")
}
```
note that if we cannot dequeue a subclassed cell here something has gone dreadfully wrong, and therefore a fatal error is raised.

We use the `setupCell` function to setup the cell's colour from within the cell - a much better solution that separates out the logic of the cell nicely. This is a good approach.


## Which to choose
You know the answer here. You are going to almost always need to perform some complex configuration on a `UICollectionViewCell`, and that will usually mean creating a subclass.

So perhaps you should be choosing a subclass solution?


# Conclusion
Yes, yes yes. This code isn't production ready. You might want to look at my [flow coordinators](https://stevenpcurtis.medium.com/flow-coordinators-using-swift-f45bd47b7a8) guide for the way I might structure an App.

However, I hope this article has given you some insight in how to set up a `UICollectionViewCell` subclass and even when you might use it.

I hope that it helps you with your coding journey, and that you have enjoyed reading this article.

Thanks!

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
