# Use AttributedString in SwiftUI Before iOS 15
## Surely Nobody Needs To?

# The Problem
Before iOS 15 AttributedString for SwiftUI wasn't a thing. Something which might produce the following result:

![Images/initialsmall.png](Images/initialsmall.png)

If you wish to have a String with text (perhaps part of the text has colour and part has a size) you might need to come up with a solution. Such a String might be:

```swift
var message: AttributedString {
    var redString = AttributedString("Is this red?")
    redString.font = .systemFont(ofSize: 18)
    redString.foregroundColor = .red
    var largeString = AttributedString("This should be larger!")
    largeString.font = .systemFont(ofSize: 24)
    return redString + largeString
}
```

How hard can it be?
In iOS 15 we would have:

```swift
Text(message)
```

But that initializer isn't available. What should we do? We would probably have the following:

```swift
HStack {
    Text("Is this red?")
        .font(.system(size: 18))
        .foregroundColor(.red)
    Text("This should be larger!")
        .font(.system(size: 24))
}
```

It's quite messy isn't it? Doesn't use the `NSAttributedString`. Quite verbose. So what should we do?
Oh, the NSAttributedString can look something like the following:

```swift
var messageAttributed: NSAttributedString {
    let redString =  NSMutableAttributedString(string: "Is this red? ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
    let largeString = NSAttributedString(string: "This should be larger!", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24)])
    redString.append(largeString)
    return redString
}
```

# The Solution
This might not be the only possible solution. It is a solution though!
If it's available use the iOS 15 [attributed String](https://developer.apple.com/documentation/foundation/attributedstring).

```swift
public extension Text {
    init(_ attributedString: NSAttributedString) {
        if #available(iOS 15.0, *) {
            self.init(AttributedString(attributedString))
        } else {
            self.init("")
            attributedString.enumerateAttributes(
                in: NSRange(location: 0, length: attributedString.length),
                options: []
            ) { (attributes, range, _) in
                let string = attributedString.attributedSubstring(from: range).string
                var text = Text(string)
                
                if let font = attributes[.font] as? UIFont {
                    text = text.font(.init(font))
                }
                
                if let colour = attributes[.foregroundColor] as? UIColor {
                    text = text.foregroundColor(Color(colour))
                }
                
                if let kern = attributes[.kern] as? CGFloat {
                    text = text.kerning(kern)
                }
                
                if #available(iOS 14.0, *) {
                    if let tracking = attributes[.tracking] as? CGFloat {
                        text = text.tracking(tracking)
                    }
                }
                
                if let strikethroughStyle = attributes[.strikethroughStyle] as? NSNumber,
                   strikethroughStyle != 0 {
                    if let strikethroughColor = (attributes[.strikethroughColor] as? UIColor) {
                        text = text.strikethrough(true, color: Color(strikethroughColor))
                    } else {
                        text = text.strikethrough(true)
                    }
                }
                
                if let underlineStyle = attributes[.underlineStyle] as? NSNumber,
                   underlineStyle != 0 {
                    if let underlineColor = (attributes[.underlineColor] as? UIColor) {
                        text = text.underline(true, color: Color(underlineColor))
                    } else {
                        text = text.underline(true)
                    }
                }
                
                if let baselineOffset = attributes[.baselineOffset] as? NSNumber {
                    text = text.baselineOffset(CGFloat(baselineOffset.floatValue))
                }
                
                self = self + text
            }
        }
    }
}
```

So this can then be used across the application. Which can now support older than iOS15 versions.
This is used as any other `Text` component in SwiftUI. Text(attributedString) would actually now achieve this.

# Conclusion
Yeah, nobody needs this type of code right now. Probably never did.
