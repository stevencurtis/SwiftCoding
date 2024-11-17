import UIKit

struct TextStyleOptions: OptionSet {
    let rawValue: Int
    static let bold = TextStyleOptions(rawValue: 1 << 0)
    static let italic = TextStyleOptions(rawValue: 1 << 1)
    static let underline = TextStyleOptions(rawValue: 1 << 2)
    static let strikethrough = TextStyleOptions(rawValue: 1 << 3)
}

print(TextStyleOptions.bold)

var styles: TextStyleOptions = [.bold, .underline]

styles.insert(.italic)

if styles.contains(.bold) {
    print("Text is bold")
}

styles.remove(.underline)

print(styles)
