import UIKit

var greeting = "Hello, playground"
print(greeting)

@propertyWrapper
struct Clamped<T: Comparable> {
    private var value: T
    private let range: ClosedRange<T>

    init(wrappedValue: T, _ range: ClosedRange<T>) {
        self.range = range
        self.value = range.contains(wrappedValue) ? wrappedValue : range.lowerBound
    }

    var wrappedValue: T {
        get { value }
        set { value = min(max(newValue, range.lowerBound), range.upperBound) }
    }
}

struct Example {
    @Clamped(0...100) var percentage: Int = 50
}

var example = Example()
example.percentage = 120
print(example.percentage) // Clamped to the upper bound of 100

