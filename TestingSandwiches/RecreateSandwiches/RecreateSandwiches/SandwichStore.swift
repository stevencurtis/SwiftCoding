//
//  SandwichStore.swift
//  RecreateSandwiches
//
//  Created by Steven Curtis on 09/10/2020.
//

import Foundation

class SandwichStore: ObservableObject {
    @Published var sandwiches: [Sandwich]
    
    init(sandwiches: [Sandwich] = []) {
        self.sandwiches = sandwiches
    }
}

let testData = SandwichStore(sandwiches: data)
