# Radians Are Useful In Swift
## Providing the conversion

# Radians
Most of the work in Swift is in Radians. This is due to the coupling of length and angle, and the resulting ease of performing certain calculations.
We can find the radius of any circle by drawing a line from the center to the edge. It doesn't matter which angle we draw this line at, as the line would always be the same length.

This leads to the conclusion that 180
π radians = 180 ° (since 3.14 radians fit into a half-circle), which leads us to conclude:
2π radians = 360 °

# The Swift Code
Since we now know the conversion between degrees and radians, we can come up with a couple of functions that will help us deal with the conversion between the two systems.
I've used static class functions here, although you'd usually host these functions in a class where they are used rather than a class which only exists for those functions

```swift
class DegreesConverter {
    static func degRad(_ number: CGFloat) -> CGFloat {
        return number * .pi / 180
    }
    
    static func radDeg(_ number: CGFloat) -> CGFloat {
        return number * 180 / .pi
    }
}
```

# Life Without Testing…
Is no life at. This article only provides a couple of example tests, but you can't have everything.

```swift
class DegreesConverterTests: XCTestCase {
    func testNinetyDegrees() {
        let radians = DegreesConverter.degRad(90)
        XCTAssertEqual(radians, 1.5707963267948966)
    }
    
    func testpiRadian() {
        let radians = DegreesConverter.radDeg(.pi)
        XCTAssertEqual(radians, 180)
    }
}
```

# Conclusion

Radians are useful in programming! Certainly many languages use radians in preference to degrees.

Lots of code requires you to deal in radians, so some experience of them or understanding of where they should be used can really help your Swift programming experience.

I certainly hope this article has helped you out!

I'd love to hear from you if you have questions

Subscribing to Medium using this link shares some revenue with me.
