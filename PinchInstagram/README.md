# Create Instagram's Pinch to Zoom using Swift
## Lightbox? No problem

# Before we start
Difficulty: Beginner | Easy | **Normal** | Challenging<br/>
This article has been developed using Xcode 12.5, and Swift 5.4

## Prerequisites:
* You will be expected to be aware how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71)
* It would be useful to be familiar with [protocol-delegate](https://stevenpcurtis.medium.com/delegation-in-swift-6b416bc0277c)

## Terminology
UIGestureRecogniser: The base class for gesture recognisers, which include tap and pinch recognisers
UIPinchGestureRecognizer: A concrete subclass of UIGestureRecogniser

# The Goal
Instagram is Great!

When you scroll up and down, the images in an apparent `UICollectionView` display. If you pinch an image it gets larger on the screen, and the background fades to black.

Can we somehow use a `UICollectionView` to do the same?

# The approach
The technique used in this implementation is to subclass a `UICollectionViewCell` and if the cell itself is pinched add an overlay `UIView` to `UIApplication.shared.windows` (it is actually possible to add it to the navigationController with something like `navigationController.view.addSubview` ).

## The subclassed cell
**Beginning**
When a pinch is detected (that is, the `UIPinchGestureRecognizer` has a state of begin), we calculate the current zoom ratio `newScale`. If this is greater than 1, we are making the image larger, and can zoom:

```swift
let newScale = currentScale * sender.scale
if newScale > 1 { 
...
```
Here we create an overlay view of the size of the current window, which will be set with an appropriate color, alpha and added to the current window (in the middle).

```swift
overlayView = UIView.init(
    frame: CGRect(
        x: 0,
        y: 0,
        width: (currentWindow.frame.size.width),
        height: (currentWindow.frame.size.height)
    )
)

overlayView.backgroundColor = UIColor.black
overlayView.alpha = CGFloat(minOverlayAlpha)
currentWindow.addSubview(overlayView)
initialCenter = sender.location(in: currentWindow)
```

We then set up a new `UIImageView` to display the image on that overlay. Essentially this is a new instance of the original `UIImageView` in size, shape and content. This particular `UIImageView` is then hidden. 

```swift
windowImageView = UIImageView.init(image: self.hotelImageView.image)
windowImageView!.contentMode = .scaleAspectFill
windowImageView!.clipsToBounds = true
let point = self.hotelImageView.convert(
    hotelImageView.frame.origin,
    to: nil
)

startingRect = CGRect(
    x: point.x,
    y: point.y,
    width: hotelImageView.frame.size.width,
    height: hotelImageView.frame.size.height
)

windowImageView?.frame = startingRect
currentWindow.addSubview(windowImageView!)
hotelImageView.isHidden = true
```

The reason the original image is hidden is because the user can actually drag the image on the overlay around, and there would be circumstances where the user would be able to see two images in that case (which wouldn't be good!)

**Changed**
While the image is being pinched the stage becomes changed. We then need to calculate the image scale, the alpha of the overlayView and transform the image to the location. At the end of this transformation, the scale is reset to 1.

```swift
let currentScale = windowImageWidth / startingRect.size.width
let newScale = currentScale * sender.scale
overlayView.alpha = minOverlayAlpha + (newScale - 1) < maxOverlayAlpha ? minOverlayAlpha + (newScale - 1) : maxOverlayAlpha
let pinchCenter = CGPoint(
    x: sender.location(in: currentWindow).x - (currentWindow.bounds.midX),
    y: sender.location(in: currentWindow).y - (currentWindow.bounds.midY)
)
let centerXDif = initialCenter.x - sender.location(in: currentWindow).x
let centerYDif = initialCenter.y - sender.location(in: currentWindow).y
let zoomScale = (newScale * windowImageWidth >= hotelImageView.frame.width) ? newScale : currentScale
let transform = currentWindow.transform
    .translatedBy(x: pinchCenter.x, y: pinchCenter.y)
    .scaledBy(x: zoomScale, y: zoomScale)
    .translatedBy(x: -centerXDif, y: -centerYDif)

// apply the transformation
windowImageView?.transform = transform
// Reset the scale
sender.scale = 1
```

**Ended**
When the user finishes pinching the image, we need to remove the overlay and hotel image from the window. This is wrapped in an animation block to make the look and feel of the Application (shall we say) acceptable:

```swift
UIView.animate(withDuration: 0.3, animations: {
    windowImageView.transform = CGAffineTransform.identity
}, completion: { _ in
    windowImageView.removeFromSuperview()
    self.overlayView.removeFromSuperview()
    self.hotelImageView.isHidden = false
    self.delegate?.zooming(started: false)
})
```

## The UIViewController
The View Controller isn't anything particular special here, and I've set this up as a programmatic `UICollectionView` and subclassed the cell (`UICollectionViewCell` as SubclassedCollectionViewCell), although in `loadView()` I've used a `UICollectionViewFlowLayout()` and set static item sizes while of course making the scroll direction vertical:

```swift
override func loadView() {
    // set up a UICollectionViewFlowLayout
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    // with a set item size
    layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 20, height: UIScreen.main.bounds.size.width / 1)
    // which scrolls vertically
    layout.scrollDirection = .vertical
    // setup the collectionview
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    // set the view as the collectionView
    self.view = collectionView
}
```
 and within the `cellForItemAt` function give the cell the required information so it can set itself up with the image:
 
 ```swift
 func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SubclassedCollectionViewCell {
         // retrieve the correct piece of data
         let data = self.data[indexPath.item]
         // tell the cell to setup with the appropriate data
         cell.setupCell(image: data)
         // setup the delegate
         cell.delegate = self
         // setup the cell
         return cell
     }
     fatalError("Could not dequeue cell")
 }
 ```

## Handling pinching and scrolling
When we are pinching we shouldn't be scrolling. To do this we use a delegate, and the `UIViewController` conforms to the delegate with the `SubclassedCollectionViewCell` having a delegate set as the `UIViewController`.

```swift
extension ViewController: SubclassedCellDelegate {
    func zooming(started: Bool) {
        self.collectionView.isScrollEnabled = !started
    }
}
```

of course setting the delegate for the cell using:

`cell.delegate = self`

which is then told if the zooming is started when we are zooming `self.delegate?.zooming(started: true)`, and stopped when the transformation is finished `self.delegate?.zooming(started: false)`.


# The complete code (with comments)

```swift
class ViewController: UIViewController {
    // This relates to the name of each image that will be displayed
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
    }

    override func loadView() {
        // set up a UICollectionViewFlowLayout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        // with a set item size
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 20, height: UIScreen.main.bounds.size.width / 1)
        // which scrolls vertically
        layout.scrollDirection = .vertical
        // setup the collectionview
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        // set the view as the collectionView
        self.view = collectionView
    }
}

extension ViewController: UICollectionViewDelegate {
    // out of the scope of this tutorial, we  print the index if that cell is selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
}

extension ViewController: UICollectionViewDataSource {
    // out of the scope of this tutorial, we will access the number of items in the data array
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return the number of images we wish to display
        data.count
    }
    
    // out of the scope of this tutorial, we dequeue the cell and setup the data in that cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SubclassedCollectionViewCell {
            // retrieve the correct piece of data
            let data = self.data[indexPath.item]
            // tell the cell to setup with the appropriate data
            cell.setupCell(image: data)
            // setup the delegate
            cell.delegate = self
            // setup the cell
            return cell
        }
        fatalError("Could not dequeue cell")
    }
}

extension ViewController: SubclassedCellDelegate {
    func zooming(started: Bool) {
        self.collectionView.isScrollEnabled = !started
    }
}
```

The `SubclassedCollectionViewCell` is defined as follows:

```swift
protocol SubclassedCellDelegate: AnyObject {
    func zooming(started: Bool)
}

class SubclassedCollectionViewCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    // the delegate property, in order to tell the collectionview that we have started / stopped zooming
    weak var delegate: SubclassedCellDelegate?
    
    // the hotel is lazily instantiated in a UIImageView
    var hotelImageView: UIImageView = {
        var hotelView = UIImageView()
        hotelView.contentMode = .scaleAspectFill
        hotelView.clipsToBounds = true
        hotelView.isUserInteractionEnabled = true
        return hotelView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // set up the pinch gesture
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(self.pinch(sender:)))
        // this class is the delegate
        pinch.delegate = self
        // add the gesture to hotelImageView
        self.hotelImageView.addGestureRecognizer(pinch)
        // add the imageview to the UICollectionView
        addSubview(hotelImageView)
        // we are taking care of the constraints
        hotelImageView.translatesAutoresizingMaskIntoConstraints = false
        // pin the image to the whole collectionview - it is the same size as the container
        hotelImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        hotelImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        hotelImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        hotelImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // the view that will be overlayed, giving a back transparent look
    var overlayView: UIView!
    
    // a property representing the maximum alpha value of the background
    let maxOverlayAlpha: CGFloat = 0.8
    // a property representing the minimum alpha value of the background
    let minOverlayAlpha: CGFloat = 0.4
    
    // the initial center of the pinch
    var initialCenter: CGPoint?
    // the view to be added to the Window
    var windowImageView: UIImageView?
    // the origin of the source imageview (in the Window coordinate space)
    var startingRect = CGRect.zero
    
    // the function called when the user pinches the collection view cell
    @objc func pinch(sender: UIPinchGestureRecognizer) {
        if sender.state == .began {
            // the current scale is the aspect ratio
            let currentScale = self.hotelImageView.frame.size.width / self.hotelImageView.bounds.size.width
            // the new scale of the current `UIPinchGestureRecognizer`
            let newScale = currentScale * sender.scale
            
            // if we are really zooming
            if newScale > 1 {
                // if we don't have a current window, do nothing
                guard let currentWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {return}
                
                // inform listeners that we are zooming, to stop them scrolling the UICollectionView
                self.delegate?.zooming(started: true)
                
                // setup the overlay to be the same size as the window
                overlayView = UIView.init(
                    frame: CGRect(
                        x: 0,
                        y: 0,
                        width: (currentWindow.frame.size.width),
                        height: (currentWindow.frame.size.height)
                    )
                )
                
                // set the view of the overlay as black
                overlayView.backgroundColor = UIColor.black
                
                // set the minimum alpha for the overlay
                overlayView.alpha = CGFloat(minOverlayAlpha)
                
                // add the subview to the overlay
                currentWindow.addSubview(overlayView)
                
                // set the center of the pinch, so we can calculate the later transformation
                initialCenter = sender.location(in: currentWindow)
                
                // set the window Image view to be a new UIImageView instance
                windowImageView = UIImageView.init(image: self.hotelImageView.image)
                
                // set the contentMode to be the same as the original ImageView
                windowImageView!.contentMode = .scaleAspectFill
                
                // Do not let it flow over the image bounds
                windowImageView!.clipsToBounds = true
                
                // since the to view is nil, this converts to the base window coordinates.
                // so where is the origin of the imageview, in the main window
                let point = self.hotelImageView.convert(
                    hotelImageView.frame.origin,
                    to: nil
                )
                
                // the location of the imageview, with the origin in the Window's coordinate space
                startingRect = CGRect(
                    x: point.x,
                    y: point.y,
                    width: hotelImageView.frame.size.width,
                    height: hotelImageView.frame.size.height
                )
                
                // set the frame for the image to be added to the window
                windowImageView?.frame = startingRect
                
                // add the image to the Window, so it will be in front of the navigation controller
                currentWindow.addSubview(windowImageView!)
                
                // hide the original image
                hotelImageView.isHidden = true
            }
        } else if sender.state == .changed {
            // if we don't have a current window, do nothing. Ensure the initialCenter has been set
            guard let currentWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }),
                  let initialCenter = initialCenter,
                  let windowImageWidth = windowImageView?.frame.size.width
            else { return }
            
            // Calculate new image scale.
            let currentScale = windowImageWidth / startingRect.size.width
            
            // the new scale of the current `UIPinchGestureRecognizer`
            let newScale = currentScale * sender.scale
            
            // Calculate new overlay alpha, so there is a nice animated transition effect
            overlayView.alpha = minOverlayAlpha + (newScale - 1) < maxOverlayAlpha ? minOverlayAlpha + (newScale - 1) : maxOverlayAlpha

            // calculate the center of the pinch
            let pinchCenter = CGPoint(
                x: sender.location(in: currentWindow).x - (currentWindow.bounds.midX),
                y: sender.location(in: currentWindow).y - (currentWindow.bounds.midY)
            )
            
            // calculate the difference between the inital centerX and new centerX
            let centerXDif = initialCenter.x - sender.location(in: currentWindow).x
            // calculate the difference between the intial centerY and the new centerY
            let centerYDif = initialCenter.y - sender.location(in: currentWindow).y
            
            // calculate the zoomscale
            let zoomScale = (newScale * windowImageWidth >= hotelImageView.frame.width) ? newScale : currentScale

            // transform scaled by the zoom scale
            let transform = currentWindow.transform
                .translatedBy(x: pinchCenter.x, y: pinchCenter.y)
                .scaledBy(x: zoomScale, y: zoomScale)
                .translatedBy(x: -centerXDif, y: -centerYDif)

            // apply the transformation
            windowImageView?.transform = transform
            
            // Reset the scale
            sender.scale = 1
        } else if sender.state == .ended || sender.state == .failed || sender.state == .cancelled {
            guard let windowImageView = self.windowImageView else { return }
            
            // animate the change when the pinch has finished
            UIView.animate(withDuration: 0.3, animations: {
                // make the transformation go back to the original
                windowImageView.transform = CGAffineTransform.identity
            }, completion: { _ in
                
                // remove the imageview from the superview
                windowImageView.removeFromSuperview()
                
                // remove the overlayview
                self.overlayView.removeFromSuperview()
                
                // make the original view reappear
                self.hotelImageView.isHidden = false
                
                // tell the collectionview that we have stopped
                self.delegate?.zooming(started: false)
            })
        }
    }
    
    // This is the function to setup the CollectionViewCell
    func setupCell(image: String) {
        // set the appropriate image, if we can form a UIImage
        if let image : UIImage = UIImage(named: image) {
            hotelImageView.image = image
        }
    }
}
```

# Conclusion
Wow, that was alot of code! Don't worry though, you can see this working through the code @  [https://github.com/stevencurtis/SwiftCoding/tree/master/PinchInstagram](https://github.com/stevencurtis/SwiftCoding/tree/master/PinchInstagram).

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis)
