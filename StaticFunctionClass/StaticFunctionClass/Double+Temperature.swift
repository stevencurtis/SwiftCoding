//
//  Double+Temperature.swift
//  StaticFunctionClass
//
//  Created by Steven Curtis on 30/12/2021.
//

extension Double {
    func celsiusToFahrenheit() -> Double {
        return self * 9 / 5 + 32
    }

    func fahrenheitToCelsius() -> Double {
        return (self - 32) * 5 / 9
    }
}
