//
//  ContentView.swift
//  TipSwiftUI
//
//  Created by Steven Curtis on 26/04/2021.
//

import SwiftUI
import Combine

struct TipView: View {
    @ObservedObject var viewModel: TipViewModel

    init(viewModel: TipViewModel) {
        self.viewModel = viewModel
    }
    
    private var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .currency
        return formatter
    }()

    var body: some View {
        Form {
            Text("Tip calculator")
                .font(.title)
            Section(header: Text("Enter Your Meal Information"), content: {
                Stepper(
                    "Guests: \(viewModel.guests.description)",
                    value: $viewModel.guests,
                    in: 0...5
                )
                CurrencyField(
                    "Enter meal cost",
                    value: Binding(get: {
                        viewModel.amount.map { NSDecimalNumber(decimal: $0) }
                    }, set: { number in
                        viewModel.amount = number?.decimalValue
                    })
                )
            })
            Section(header: Text("Select Tip Percentage"), content: {
                Picker("Select", selection: $viewModel.selectedTipIndex) {
                    ForEach(Range(0...2)) { value in
                        Text(viewModel.tipPercentages[value].description).tag(value)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            })
            Section(header: Text("To Pay:"), content: {
                Text("Tip to Pay \(currencyFormatter.string(from: viewModel.tip ?? 0) ?? "0")")
                Text("Tip Per Guest \(currencyFormatter.string(from: viewModel.guestTip ?? 0) ?? "0")")
                Text("Total to Pay \(currencyFormatter.string(from: viewModel.toPay ?? 0) ?? "0")")
            })
        }
    }
}

struct TipView_Previews: PreviewProvider {
    static var previews: some View {
        TipView(viewModel: TipViewModel())
    }
}
