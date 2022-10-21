# Pinch to Zoom a UICollectionViewCell in a UICollectionView
## Make sure isUserInteractionEnabled is true

# Before we start
Difficulty: Beginner | Easy | **Normal** | Challenging<br/>
This article has been developed using Xcode 12.2, and Swift 5.3

## Prerequisites:
* You will be expected to be aware of how to make a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71) in Swift.
* Subclass [UICollectionViewCell](https://medium.com/geekculture/create-a-uicollectionview-programmatically-8d62a3802b0f)
* This article builds on my [Fade the First and Last Elements in a UICollectionView](https://stevenpcurtis.medium.com/fade-the-first-and-last-elements-in-a-uicollectionview-3fc2cdfb0f46) article

## Keywords and Terminology:
UICollectionView: An object that manages an ordered collection of data items and presents them using customizable layouts

# This project
## The motivation
If you want to create a `UICollectionView` where you can pinch to zoom the images, then you're in the right place!

## The Project
This project built upon an article where I managed to get `UICollectionViewCell` instances to fade in a `UICollectionView` if they are either the first or last element in the view. This particular article, therefore, focuses on the gestures that go into the `UICollectionViewCell` instances. 

I've even got an article about adding pinch gestures [to a UIImageView](https://medium.com/@stevenpcurtis.sc/add-pinch-to-zoom-to-uiimageview-classes-da390f6905d5)

## The Overview
We will need to conform to `SubclassedCollectionViewCell` to receive messages from the gesture recognizer, which is set up as follows:

```swift
// set up the pinch gesture
let pinch = UIPinchGestureRecognizer(target: self, action: #selector(self.pinch(sender:)))
// this class is the delegate
pinch.delegate = self
// add the gesture to hotelImageView
self.hotelImageView.addGestureRecognizer(pinch)
```

Which will call a delegate function `@objc func pinch(sender:UIPinchGestureRecognizer) ` that must be visible to Objective-C and therefore has the keyword `@objc`.

More than that, in our cell we will store two properties (initialCenter and isZooming)

```swift
var initialCenter: CGPoint?
var isZooming = false
```

If we are beginning our first pinch we will run the following code:

```swift
// calculate the image scale
let currentScale = self.hotelImageView.frame.size.width / self.hotelImageView.bounds.size.width
// calculate the image scale after the pinch
let newScale = currentScale * sender.scale
// if we are really zooming, set the boolean
if newScale > 1 {
    self.isZooming = true
    // bring the cell to the front of the superview
    self.superview?.bringSubviewToFront(self)
}
```

Yet if this is a continuous gesture we will run:

```swift
guard let view = sender.view else {return}
// set the center of the gesture
let pinchCenter = CGPoint(x: sender.location(in: view).x - view.bounds.midX,
                          y: sender.location(in: view).y - view.bounds.midY)
// set the transformation
let transform = view.transform.translatedBy(x: pinchCenter.x, y: pinchCenter.y)
    .scaledBy(x: sender.scale, y: sender.scale)
    .translatedBy(x: -pinchCenter.x, y: -pinchCenter.y)
// set the current scale of the image
let currentScale = self.hotelImageView.frame.size.width / self.hotelImageView.bounds.size.width
// set the scale once the gesture is complete
var newScale = currentScale * sender.scale
// if the scale is to reduce the size of the cell
if newScale < 1 {
    // set the cell back to the original point
    newScale = 1
    let transform = CGAffineTransform(scaleX: newScale, y: newScale)
    self.hotelImageView.transform = transform
    // set the scale back to one
    sender.scale = 1
} else {
    // make the transformation
    view.transform = transform
    // set the scale back to one
    sender.scale = 1
}
```

If we are finishing the gesture, the following:

```swift
// animate the pop back to the original place for the UIImageView
UIView.animate(withDuration: 0.3, animations: {
    // set the transform
    self.hotelImageView.transform = CGAffineTransform.identity
}, completion: { _ in
    // we are no longer zooming
    self.isZooming = false
})
```

The full code is in the [repo](https://github.com/stevencurtis/SwiftCoding/tree/master/PinchToZoomUICollectionViewCell)

# Conclusion
You should know if you follow this logic for a `UITableViewCell` you don't have to conform to `UIGestureRecognizerDelegate`. In this case, you do follow the same logic, but don't worry too much as you can do it!


If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
