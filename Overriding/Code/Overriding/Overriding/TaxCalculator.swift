//
//  TaxCalculator.swift
//  Overriding
//
//  Created by Steven Curtis on 09/12/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation

class TaxCalculator: SalesCalculator {
    override func income(sellingPrice: Double) -> Double {
        return sellingPrice * 0.8
    }
}
