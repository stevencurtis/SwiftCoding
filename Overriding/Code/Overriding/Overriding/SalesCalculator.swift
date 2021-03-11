//
//  Calculator.swift
//  Overriding
//
//  Created by Steven Curtis on 09/12/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation

class SalesCalculator {
    var salesPrice = 20
    
    func income(sellingPrice: Double) -> Double {
        return sellingPrice
    }
    
    func getSalesPrice() -> Int {
        return salesPrice
    }
}
