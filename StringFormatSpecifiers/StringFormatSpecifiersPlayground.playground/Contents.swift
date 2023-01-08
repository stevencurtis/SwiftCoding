import UIKit

let basicNumber: Int = 42
print(String(format: "%d", basicNumber)) // 42
print(String(format: "Basic Number: %d", basicNumber)) // Basic Number: 42


let leadingZeros: Int = 5
let leadingStr1 = String(format: "%03d", leadingZeros) // 005
let leadingStr2 = String(format: "%05d", leadingZeros) // 00005

let trailingZeros: Float = 7.9857
let trailingStr1 = String(format: "%.2f", trailingZeros) // 7.99
let trailingStr2 = String(format: "%.4f", trailingZeros) // 7.9857

let hexNumber: Int = 1616
let hexStr1 = String(format: "%2X", hexNumber) // 650

let doubleNumber: Double = 42.7
print(String(format: "%.1f", doubleNumber)) // 42.7
print(String(format: "Double Number: %.1f", doubleNumber)) // Double Number: 42.7

let anotherDoubleNumber: Double = 12.345678
print(String(format: "%.3f", anotherDoubleNumber)) // 12.346
print(String(format: "Double Number: %.3f", anotherDoubleNumber)) // Double Number: 12.346

print(String(format: "Hello, %@.", "World")) // Hello, World

print(String(format: "First word: %2$@, Second word: %1$@", "world", "Hello")) // First word: Hello Second word: world

print(String(format: "99% of the %@ is accurate", "test")) // "991035662052f the (null) is accurate\n

print(String(format: "99%% of the %@ is accurate", "test")) // 99% of the test is accurate

print(String(format: "%u...%u", UInt32.min, UInt32.max)) // 0...4294967295

print(String(format: "greatest %e", Double.greatestFiniteMagnitude)) // greatest 1.797693e+308

print(String(format: "The first letter is: %c", "A".utf8.first!)) // The first letter is: a

print(String(format: "The first letter is: %C", "你".utf16.first!)) // The first letter is: 你

print(String(format: "The first letter is: %c", "你".utf16.first!)) // The first letter is: \n

print(
    "Hello, world!".withCString {
        String(format: "%s", $0)
    }
) // Hello, world!

print(
    "Hello, world!".withCString(encodedAs: UTF16.self) {
        String(format: "%S", $0)
    }
) // Hello, world!

var text = "Hello, World!"
print(
    withUnsafePointer(to: &text) {
        String(format: "%p", $0)
    }
) // 0x1056089b0

print(String(format: "from %X to %A", UInt32.min, UInt32.max))
print(UInt32.max)

print(String(format: "%s", "Hello, World!"))
