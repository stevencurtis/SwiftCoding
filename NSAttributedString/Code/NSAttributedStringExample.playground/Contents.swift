import UIKit

//interactiveLinkTextView.attributedText = fullAttributedString

let plainString = "Boring text"
let attributedString = NSAttributedString(string: plainString)


let font = UIFont.systemFont(ofSize: 72)
let attributes = [NSAttributedString.Key.font: font]
let largerString = "Larger text"
let attributedLergerString = NSAttributedString(string: largerString, attributes: attributes)


let coloredString = "Colour?"
let redLinkString = NSAttributedString(string: coloredString, attributes:[NSAttributedString.Key.foregroundColor: UIColor.red])
let mixedString = "This should be red: "
let mixedMutableString = NSMutableAttributedString(string: mixedString, attributes: attributes)

mixedMutableString.append(redLinkString)


let bigAndRedString = "Big AND RED"
let bigAndRedAttributedString = NSMutableAttributedString(string: bigAndRedString)
let bigAttributes: [NSAttributedString.Key: Any] = [ NSAttributedString.Key.font: font]
bigAndRedAttributedString.addAttributes(bigAttributes, range: NSRange(location: 0, length: 3))
let redAttributes: [NSAttributedString.Key: Any] = [ NSAttributedString.Key.foregroundColor: UIColor.red]
bigAndRedAttributedString.addAttributes(redAttributes, range: NSRange(location: 1, length: 3))

