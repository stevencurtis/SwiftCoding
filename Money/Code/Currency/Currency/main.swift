//
//  main.swift
//  Currency
//
//  Created by Steven Curtis on 28/05/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

// https://floating-point-gui.de
let result: Double = 0.1 + 0.2
print (result)

let tenPence: Decimal = 0.1
let twentyPence: Decimal = 0.2

print (tenPence == tenPence)

let correctResult = tenPence + twentyPence
print (tenPence + twentyPence)

extension NumberFormatter {
    static var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_GB")
        return formatter
    }
}


print(NumberFormatter.currencyFormatter.locale!)
print("GB", NumberFormatter.currencyFormatter.string(from: correctResult as NSDecimalNumber)!)
