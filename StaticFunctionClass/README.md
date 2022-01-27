# Swift Helper Functions
## I've been doing it wrong!

Imagine you've got some helper functions you'd like to use in your Swift project.
There are a few different options for you to place these helper functions.
Let us take a look at a few of them, and decide whether they might be used in your project
Difficulty: **Beginner** | Easy | Normal | Challenging

# Prerequisites:
Be able to create a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71), and or use Playgrounds to produce some Swift code. One of the examples is more complex, and for that understanding [subclassing a view](https://medium.com/r/?url=https%3A%2F%2Fstevenpcurtis.medium.com%2Fsubclassing-uiview-in-swift-d372c67b7f3) would be useful.

# Criteria for choosing an approach
Our code will be within our project, so this is about the approach and how well this might fit within your target project in terms of design.

# Create a function inside a struct
Functions need to relate to the hosting struct to make sense. The frequently internal functions should not really be available from outside the struct (so should be private) so you'll only be using the function(s) from within the target struct or we really need to think how the public API of our struct might be used.

```swift
struct Person {
    let name: String
    let age: Int
    
    func formattedPerson() -> String {
        return "\(name) is \(age) years old"
    }
}

let dave = Person(name: "Dave", age: 11)
let result = dave.formattedPerson()
```

Lines 10 and 11 sample how this function might be used from outside this Struct.

# Create a function outside any particular class or struct

If the functions are truly global in scope, and do not belong to any hosting class or struct this could be the option for you.
It might be difficult to get hold of an example that will pass your code review, so in this case I've come up with a rather silly example.

```swift
func printThis(item: String) {
    print(item)
}

printThis(item: "test")
```

Where line 5 would be used in a sensible place in your code.
If you want to follow this approach you need to be mindful about namespace collisions.

# Place functions in an extension

Inevitably you will be using some existing data type in using your functions. This means we can make use of the functions in Swift

```swift

extension Double {
    func celsiusToFahrenheit() -> Double {
        return self * 9 / 5 + 32
    }

    func fahrenheitToCelsius() -> Double {
        return (self - 32) * 5 / 9
    }
}

let boilingPoint = 100.0
print("The boiling point in celsius is \(boilingPoint)")
let farenheit = boilingPointCelsius.celsiusToFahrenheit()
print("The boiling point in farenheit is \(farenheit)")
```

From line 11 to 14 we have an example of how celsius to Fahrenheit might be used.

# Create a function insides a class, marking it as static

We generally make helper functions `static` when placed in a `class`, and means we can use these functions from outside the class.
Here I have a rather complex example, as this is the type of code that I'm writing regularly in one of my other lives.

```swift
class DrawArcView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        drawArc()
    }
    
    func drawArc() {
        let bP = UIBezierPath(
            arcCenter: CGPoint(x: 50, y: 128),
            radius: 50,
            startAngle: 180 * .pi / 180,
            endAngle: 0 * .pi / 180,
            clockwise: true
        )
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.blue.cgColor
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.lineWidth = 2.0
        shapeLayer.path = bP.cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
    
    func drawArc(startRadians: CGFloat, endRadians: CGFloat) {
        let bP = UIBezierPath(
            arcCenter: CGPoint(x: 50, y: 128),
            radius: 50,
            startAngle: startRadians,
            endAngle: endRadians,
            clockwise: true
        )
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.blue.cgColor
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.lineWidth = 2.0
        shapeLayer.path = bP.cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
    
    func drawArc(startDegrees: CGFloat, endDegrees: CGFloat) {
        let bP = UIBezierPath(
            arcCenter: CGPoint(x: 50, y: 128),
            radius: 50,
            startAngle: DrawArcView.degRad(startDegrees),
            endAngle: DrawArcView.degRad(endDegrees),
            clockwise: true
        )
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.blue.cgColor
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.lineWidth = 2.0
        shapeLayer.path = bP.cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
    
    static func degRad(_ number: CGFloat) -> CGFloat {
        return number * .pi / 180
    }
}
```

If we use this code programatically (that is, not from the storyboard) we might do something like the following:

```swift
drawView.drawArc(startDegrees: 0, endDegrees: 90)
```

but if we would like to access the function from the outside of the class (or actually from within the class) we will call the following code (or something similar):

```swift
let startDegrees = 180
DrawArcView.degRad(startDegrees)
```

# So, which?
I think it's obvious from the notes above, as well as repo with this code https://github.com/stevencurtis/SwiftCoding/tree/master/StateFunctionClass that for me, in most cases I use a class with static functions.
Should you? Well, that really depends on the work you're doing. But yes, I'd usually use a class with static functions.

# Conclusion
In programming there are no absolutes. You can't guarantee that any particular solution will be the ideal one for you to use. So take a look at the alternatives, and think about the best way to approach the problem that you are trying to solve.

All the best!

I'd love to hear from you if you have questions

Subscribing to Medium using this link shares some revenue with me.
