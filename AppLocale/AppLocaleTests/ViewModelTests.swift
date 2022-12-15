//
//  ViewModelTests.swift
//  AppLocaleTests
//
//  Created by Steven Curtis on 08/12/2022.
//

@testable import AppLocale
import XCTest

final class ViewModelTests: XCTestCase {
    func testFunction() {
        let viewModel = ViewModel()
        XCTAssertEqual(viewModel.temperature(), "32°F")
    }
    
    func testFunctionLocale() {
        let temperature = Measurement(value: 0, unit: UnitTemperature.celsius)
        let formatter = MeasurementFormatter()
        formatter.locale = .current
        let expected = formatter.string(from: temperature)
        
        let viewModel = ViewModel()
        XCTAssertEqual(viewModel.temperature(), expected)
    }
}
