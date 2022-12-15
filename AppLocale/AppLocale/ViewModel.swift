//
//  ViewModel.swift
//  AppLocale
//
//  Created by Steven Curtis on 08/12/2022.
//

import Foundation

final class ViewModel {
    func temperature() -> String {
        let temperature = Measurement(value: 0, unit: UnitTemperature.celsius)
        let formatter = MeasurementFormatter()
        return formatter.string(from: temperature)
    }
}
