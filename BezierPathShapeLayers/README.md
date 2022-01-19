# Bézier Path and Curves Using Core Graphics
## Providing great interfaces

Difficulty: Beginner | Easy | **Normal** | Challenging

# Prerequisites:
Be able to create a [Single View Application](https://medium.com/swlh/your-first-ios-application-using-xcode-9983cf6efb71), and this tutorial expects that you are comfortable with [Subclassing UIView](https://medium.com/@stevenpcurtis.sc/subclassing-uiview-d372c67b7f3)

# Terminology

Bézier: A line or path used to create vector graphics
CGContext: A graphics context that contains drawing parameters required to draw on the destination


The example App shows several ways of creating Bézier paths and Bézier curves, displayed in a [scrollable stackview](https://medium.com/@stevenpcurtis.sc/create-a-uistackview-in-a-uiscrollview-e2a959fa061).

# Core graphics?

There are three ways to draw a Bézier Path in Swift
- Use the draw(_:) method on a UIView subview context
- Create and use CAShapeLayer
- Create and use a CGContext context

# The example step-by-step - draw(_:)

A simple line using draw(_:) is relatively simple, since the UIBezierPath() is written directly on the rootlayer and therefore uses the current context and therefore this doesn't need to be passed in explicitly. stroke() adds the  UIBezierPath to the current context using the attributes of the current Bézier path. Great!
The following example produces a single line on the screen using this method:

[DrawLineOne.png.png](Images/DrawLineOne.png.png)

The result of this is a simple blue line (from the top-left hand corner of the screen).

[DrawLine.png](Images/DrawLine.png)

Although draw(_:) is a nice way of doing this, since it provides the context there is also a performance penalty for overriding draw(_:) since draw(_:) can be called many times. Never fear though, there are other ways!

# The example step-by-step - CAShapeLayer
The common approach to this is by creating a UIBezierPath() and then assigning it to a CAShapeLayer(). The shape layer is created as a sublayer (rather than a mask, more on that later).

[DrawLineCALayer.png](Images/DrawLineCALayer.png)

Since CAShapeLayer is a CALayerSubclass we have the opportunity to produce some fun animations.

# The example step-by-step - CGContext

This is actually an extension of the first example, since draw(_:) has an inbuilt context (the UIView graphics context!) we can just ask for that. This allows us to setStrokeColor(_:) and setLineWidth(_:) in the context. We can note that we are using the cgColor variant of a UIColor, and equally we add a CGMutablePath which (importantly) is added to the context, although this still needs to be painted through the strokePath() method.
Note that here we are using a CGMutablePath() to create our line, and avoiding the use of UIBezierPath() at all!

[DrawRect.png](Images/DrawRect.png)

Because CGPath is part of Core Graphics it is rather more flexible than using UIBezierPath() alone.

# Considerations

## Coordinate Systems
In iOS many things are upside down comparing to what we know from the usual math. Take for example the coordinate system: When moving towards bottom in iOS (vertical axis) the Y value is increased, while it gets decreased in a Cartesian coordinate system (math).
The origin, incidentally, will be in the top left-hand corner of the device orientation.

[coordinates.png](Images/coordinates.png)

This really matters because if you are operating in a UIView you need to use func move(to point: CGPoint) (and the documentation for the same mentions we must be in the current coordinate system). So that drawLine function?

```swift
class DrawLine: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        drawLine()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        drawLine()
    }
    
    func drawLine() {
        let bP = UIBezierPath()
        bP.move(to: CGPoint(x: 0, y: 0))
        bP.addLine(to: CGPoint(x: 50, y: 100))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.path = bP.cgPath
        shapeLayer.lineWidth = 5.0
        
        self.layer.addSublayer(shapeLayer)
    }
}
```

the UIBezierPath is moved to the origin and then to (50,100). So we are expecting some action in the upper left hand corner of this view (depending on the size of the host UIView of course).

# Rotation

Bézier path arcs are created in a clockwise direction. This is actually radians in the Core Graphics world (which is always useful as it couples length and angle into one measurement, but that is for another time).
This means that zero degrees really faces "to the left".

[Degrees.png](Images/Degrees.png)

if we wish to draw an arc

```swift

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
```

Which gives the result (as in the repo https://github.com/stevencurtis/SwiftCoding/tree/master/DrawBezierPath)on an app as the following pattern on the screen:

[drawarc.png](Images/drawarc.png)

That is, the arc starts on the right hand side at 0 ° and swings around to 180 °.

# The theory - Core Graphics vs. Bézier paths
## Bézier path

A UIBezierPath() is a vector-based path that can be used for vector shapes (like rectangles) or more complex paths. These can be filled using the drawing properties of the path itself. Contains properties including lineWidth, lineJoinStyle,lineCapStyle,miterLimit andflatness. UIBezierPath() is part of UIKit rather than Core Graphics.

## CGContext

Since a CGContext represents where something should be drawn, and the context can be told what specifically to draw. There are specific contexts for drawing to bitmapped images, PDF files and (the focus of this article) drawing to a UIView. When you set a fill color or a line width the setting persists for the complete context (certainly until it is changed).

## CGMutablePath

This is (obvs.) the mutable version of a CGPath that is a mathematical description of shapes that can be drawn in a particular context. The drawing properties are part of the CGContext rather than of the CGPath; that is a CGPath doesn't have any line thicknesses or color properties.

## Core graphics

Core graphics is a fun framework that can be used to customize your UI, perhaps even adding great animation effects as you go. It is certainly a great way of drawing shapes and creating shapes with gradients and…so much more…

# Conclusion

Like many things in programming, this is as easy or as difficult as you want it to be. To put it another way, when you do it right you do it once. To put it another way, complexity makes things easier. To put it another way, do it your way. To put it another way; you need to choose which of the last two implementations in your particular project. You decide!
I'd love to hear from you if you have questions
Subscribing to Medium using this link shares some revenue with me.
