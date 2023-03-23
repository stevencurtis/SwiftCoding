//: [Previous](@previous)

import Foundation

var taskLocal = TaskLocal<String>(wrappedValue: "Original value")

func printTaskLocalValue() async {
    let value = taskLocal.get()
    print(value)
}

let taskUnchanged = Task {
    await printTaskLocalValue()
}

let taskWithLocalChange = Task {
    await taskLocal.withValue("Hello, World!") {
        await printTaskLocalValue()
        await printTaskLocalValue()
    }
    await printTaskLocalValue()
}

let taskUnchangedAgain = Task {
    await printTaskLocalValue()
}

// More complex example

enum Currency: String {
    case USD, EUR, JPY
}

struct CurrencyConverter {
    let conversionRates: [Currency: Double] = [
        .USD: 1.0,
        .EUR: 0.85,
        .JPY: 110.25
    ]

    func convert(amount: Double, to currency: Currency) -> Double {
        guard let conversionRate = conversionRates[currency] else {
            return amount
        }
        return amount * conversionRate
    }
}

struct UserPreference {
    @TaskLocal static var preferredCurrency: Currency = .JPY
}

func displayConvertedAmount(amount: Double) {
    let converter = CurrencyConverter()
    let preferredCurrency = UserPreference.preferredCurrency
    let convertedAmount = converter.convert(amount: amount, to: preferredCurrency)
    print("Amount in \(preferredCurrency.rawValue): \(convertedAmount)")
}

displayConvertedAmount(amount: 100)

// change default
UserPreference.$preferredCurrency.withValue(.EUR) {
    displayConvertedAmount(amount: 100)
}
//: [Next](@next)
