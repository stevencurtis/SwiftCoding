import SwiftUI

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
