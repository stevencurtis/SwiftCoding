# How I Might Implement A Spacing System in A Design Library
## I've been thinking about this

This runs alongside my development of a simple design library system that I'm going to import in my project apps and tutorial projects. Take a look at (https://github.com/stevencurtis/DesignLibrary/tree/main)[https://github.com/stevencurtis/DesignLibrary/tree/main]

Difficulty: Beginner | **Easy** | Normal | Challenging<br/>
This article has been developed using Xcode 15.0, and Swift 5.9

## Terminology:
CGFloat: A floating-point data type used in the Core Graphics framework 

# Justification for a spacing system
When coding in Swift spacings are often hardcoded or perhaps use magic numbers that are not easy to understand trough your app.

## Setting constraints without a spacing system
You might wish to simply set some constraints without a spacing system. Nothing particularly unusual or challenging about this.

```swift
// Setting up constraints without a spacing system
view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 11).isActive = true
view.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -22).isActive = true
view.topAnchor.constraint(equalTo: superview.topAnchor, constant: 15).isActive = true
```

So the constraints are hardcoded and might match a designer's work in a pixel-perfect way. 

Let me say there is nothing **wrong** with this approach. However we might want a more consistent way of spacing within our app and create a uniform approach.

## Benefits of a standardised spacing system

**Consistency**
A uniform look and feel across your app, enhancing the user experience and stopping the need to ask the designer 'is this right?'.
**Efficiency**
Reduces the decision-making process for developers and designers, speeding up the development workflow.
**Scalability**
Makes it easier to adjust the spacing system globally as your design evolves.

# Implementing a simple spacing system
I've placed a simple file `Spacing.swift` into my design library. The content is the following:

```swift
import Foundation

public enum Spacing: CGFloat {
    case pt0 = 0
    case pt4 = 4
    case pt8 = 8
    case pt12 = 12
    case pt16 = 16
    case pt24 = 24
    case pt32 = 32
    case pt48 = 48
    case pt64 = 64
    case pt72 = 72
}
```

If we continue the example from below we can now use the standardised system from above.

```swift
// Setting up constraints using a spacing system
view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: Spacing.pt8.rawValue).isActive = true
view.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -Spacing.pt16.rawValue).isActive = true
view.topAnchor.constraint(equalTo: superview.topAnchor, constant: Spacing.pt12.rawValue).isActive = true
```

This means that users of the design system need to use multiples of 4 in their application. Putting spacing of 23 or 3.45 simply isn't an option. In the short term this might mean more to and fro between developers and a designer but in the long term should foster adherence to the system.

By using the Spacing enum, you're not only making the code more readable but also ensuring that spacings are consistent across the app. If you decide to adjust the spacing scale, you only need to update the Spacing enum, and the changes will be reflected throughout the app.

## Integrating with Design Tools
There is a further opportunity here. To ensure that your spacing system is consistently applied across both development and design we can collaborate with designers and integrate these spacing values into design tools.

This alignment between design and development streamlines the UI implementation process and reduces discrepancies that should be a big win all round.

# Conclusion
Implementing a standardised spacing system in your design library is a simple yet impactful way to enhance the consistency and quality of your app's UI. By using a CGFloat-based enum like Spacing, you can ensure precise and flexible layout definitions that align with your design principles.

Thanks for reading!

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis) 
