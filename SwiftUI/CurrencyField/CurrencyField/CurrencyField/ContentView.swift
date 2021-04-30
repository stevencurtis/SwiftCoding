//
//  ContentView.swift
//  CurrencyField
//
//  Created by Steven Curtis on 30/04/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var stringAmount: String = ""
    @State private var amount: Decimal?
    
    var body: some View {
        TextField("Amount", text: $stringAmount)
            .keyboardType(.decimalPad)
        
        CurrencyField(
            "Enter meal cost",
            value: Binding(get: {
                amount.map { NSDecimalNumber(decimal: $0) }
            }, set: { number in
                amount = number?.decimalValue
            })
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
