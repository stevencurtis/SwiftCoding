//
//  CurrencyField.swift
//  TipSwiftUI
//
//  Created by Steven Curtis on 26/04/2021.
//

import SwiftUI

public struct CurrencyField: View {
    let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    
    let currencyEditingFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    let title: String
    let value: Binding<NSNumber?>
    @State private var valueWhileEditing: String = ""
    @State private var isEditing: Bool = false
    
    public init(_ title: String,
                value: Binding<NSNumber?>
    ) {
        self.title = title
        self.value = value
    }
    
    public var body: some View {
        TextField(
            title,
            text: Binding(
                get: {
                    self.isEditing ?
                        self.valueWhileEditing :
                        self.formattedValue
                }, set: { newValue in
                    let strippedValue = newValue.filter{ "0123456789.".contains($0) }
                    if strippedValue.filter({$0 == "."}).count <= 1 {
                        self.valueWhileEditing = strippedValue
                        self.updateValue(with: strippedValue)
                    } else {
                        let newValue = String(
                            strippedValue.dropLast(strippedValue.count - self.valueWhileEditing.count)
                        )
                        self.valueWhileEditing = newValue
                        self.updateValue(with: newValue)
                    }
                }
            ), onEditingChanged: { isEditing in
                self.isEditing = isEditing
                self.valueWhileEditing = self.formattedValue
            }
        )
    }
    
    private var formattedValue: String {
        guard let value = self.value.wrappedValue else { return "" }
        let formatter = isEditing ? currencyEditingFormatter : currencyFormatter
        guard let formattedValue = formatter.string(for: value) else { return "" }
        return formattedValue
    }
    
    private func updateValue(with string: String) {
        let newValue = currencyEditingFormatter.number(from: string)
        let newString = newValue.map { currencyEditingFormatter.string(for: $0) } as? String
        value.wrappedValue = newString.map { currencyEditingFormatter.number(from: $0) } as? NSNumber
    }
}
