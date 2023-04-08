# Mastering the Three Phases of iOS Layout with Auto Layout
## Swift programming

Difficulty: Beginner | **Easy** | Normal | Challenging<br/>

## Keywords and Terminology:
Auto Layout: A constraint-based layout system
intrinsicContentSize: The natural size for the receiving view, considering only properties of the view itself
Superview: The superview is the immediate ancestor of the current view
Subview: The subview is a child of the current view

# The Three Phases to Display a View
In order to display a view there are three phases:
- update constraints
- update layout
- update display

## Step 1: Updating Constraints
Constraints are calculated that set the frame of views, from each subview to superview (so moving up the hierarchy). This can be triggered by calling `setNeedsUpdateConstraints`, or through any changes to constraints. 

Within a custom view `updateConstraints` can be overridden with something like the following:

```swift
// will run multiple times, so don't add new constraints but rather update the existing one
override func updateConstraints() {
    if didSetupConstraints == false {
        configureAutolayoutConstraints()
    }
    
    super.updateConstraints()
}
```

which of course in this example would call `configureAutolayoutConstraints()` just once.

## Step 2: layout
This works from superview to subview, and sets the center and bounds of views. This can be triggered with `setNeedsLayout`(which triggers a layout update during the next cycle). To force an immediate update `layoutIfNeeded` can be called.

## Step 3: Render views to the screen
This operates from superview to subview and can be triggered by calling `setNeedsDisplay`, and is connected to `drawRect:` in custom view subclasses. 

## The iterative process
Auto Layout is an iterative process, and one pass is not always enough. This is particularly important in that if a custom implementation calls `layoutSubviews` an infinite loop may occur.

# Conclusion

If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis)
