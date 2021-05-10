//
//  TipViewModel.swift
//  TipSwiftUI
//
//  Created by Steven Curtis on 26/04/2021.
//

import Foundation
import SwiftUI
import Combine

class TipViewModel: ObservableObject {
    // output
    @Published var tip: NSDecimalNumber?
    @Published var guestTip: NSDecimalNumber?
    @Published var toPay: NSDecimalNumber?
    
    // input
    @Published var amount: Decimal?
    @Published var guests = 2
    @Published var selectedTipIndex = 0
        
    let tipPercentages = [15, 20, 25]

    private var cancellable: Set<AnyCancellable> = []
    
    init() {
        $amount
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.calculateTip()
            })
            .store(in: &cancellable)
        
        $guests
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.calculateTip()
            })
            .store(in: &cancellable)

        $selectedTipIndex
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.calculateTip()
            })
            .store(in: &cancellable)
    }
    
    var tipPercentage: Int = 0
    let tipChoices = [10,15,20,25]
    
    func calculateTip() {
        guard let amount = amount else {
            return
        }
        
        let tipPercentage = (Double(tipPercentages[selectedTipIndex]) / 100) * NSDecimalNumber(decimal: amount).doubleValue / Double(guests)
        tip = NSDecimalNumber(value: tipPercentage)
        guestTip = NSDecimalNumber(value: tipPercentage / Double(guests))
        toPay = NSDecimalNumber(decimal: amount).adding(tip!)
    }
}
