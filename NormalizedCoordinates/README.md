# Which Way is Up? Normalized Coordinates in Swift
## AKA my struggles with Vision

You know what. It is really annoying being an iOS developer sometimes. People laugh at you in the street (probably, I'm not sure as I don't go outside), usually because you don't know which way is **up**.

## The Core Issue
I simply didn't understand **which coordinate space** vision worked in. Yeah, the [documentation](https://medium.com/r/?url=https%3A%2F%2Fdeveloper.apple.com%2Fdocumentation%2Fvision%2F2908993-vnimagerectfornormalizedrect) presupposes that you understand "normalized coordinate space" but I didn't. A great deal of pain then occurred.
The outcome is this article.

## UIKit
Most of my experience in Swift is with UIKit. This means that the top-left hand corner of the screen is the origin point.

[Coordinates](Images/Coordinates.png)

The paradigm at play here is one that has [existed for decades, perhaps because](https://medium.com/r/?url=https%3A%2F%2Flearn365project.com%2F2015%2F08%2F01%2Fwhy-do-computer-coordinates-start-from-the-upper-left-corner%2F) in western countries people read from left-right in a downwards direction.

There are subviews coordinate spaces here. That is, you need to know which coordinate space you are in to know which `CGPoint` is being touched.

That is, a touch on the top-left corner of the blue `UIView` below might be at (0,0) for that coordinate space. But the view controller's coordinate space? That is (328,0).

[topleftbluesmaller](Images/topleftbluesmaller.png)

## Core Graphics
Here we use a slightly different programming paradigm, in that the origin is in the lower left-hand corner of the view or window. When we have the origin in the lower left-hand corner is the Y-axis runs upwards (according to the screen).

[NormalizedCoordinates.png](Images/NormalizedCoordinates.png)

## AVFoundation Coordinates
Let us take a rectangle from an [AVCaptureMetadataOutput](https://medium.com/r/?url=https%3A%2F%2Fdeveloper.apple.com%2Fdocumentation%2Favfoundation%2Favcapturemetadataoutput%3Flanguage%3Dobjc) object. Here we have an origin in the top-left but the  X and Y axis are both in the range 0…1.

[AVFoundation.png](Images/AVFoundation.png)

## Vision Coordinates

I recently wanted to draw a bounding box for a `VNRectangleObservation`. Now `VNRectangleObservation` returns the four vertices of a detected rectangle, which you might see as a easy mapping to the screen. However, these are *normalized coordinates*.

This means that we are in a coordinate system where the lower-left corner is the origin, and the values are relative to the pixel dimension of the input image. That is, the X and Y axis are both in the range 0…1.

Since we are using Vision, we need to take into account the orientation of the camera input, which may not be mapped to the orientation of the screen. It is possible to lock the user and `connection.videoOrientation = .portrait` might well be necessary.

Even with these restrictions, mapping to the screen is not that easy and I have previously used to the following function in order to draw a bounding box around a `VNRectangleObservation`:

``` swift
func drawBoundingBox(rect : VNRectangleObservation) {
    let transform = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -self.previewLayer.frame.height)
    let scale = CGAffineTransform.identity.scaledBy(x: self.previewLayer.frame.width, y: self.previewLayer.frame.height)

    let bounds = rect.boundingBox.applying(scale).applying(transform)
    createLayer(in: bounds)
}
```

## Further Materials
There are a whole bunch of materials around on this topic. However, you might benefit from using https://developer.apple.com/library/archive/documentation/General/Conceptual/Devpedia-CocoaApp/CoordinateSystem.html from Apple when coding and taking a look through the coordinate systems for yourself!

# Conclusion

When Front End and Mobile developers work they bring different paradigms from programming, design and elsewhere.
Why would coordinates be any different? Unfortunately for those unaware about the history of these coordinate systems and their quirks this can be a "gotcha" for developers. I hope that readers of this article have avoided this particular "gotcha" and are temped to study this topic area a little more in future.
Subscribing to Medium using this link shares some revenue with me.
If you've any questions, comments or suggestions please hit me up on Twitter
