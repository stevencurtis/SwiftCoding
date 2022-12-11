import UIKit

func convertTemperature(_ celsius: Double) -> [Double] {
    let celsius = Measurement(value: celsius, unit: UnitTemperature.celsius)
    let fahrenheit = celsius.converted(to: UnitTemperature.fahrenheit)
    let kelvin = celsius.converted(to: UnitTemperature.kelvin)
    return [kelvin.value, fahrenheit.value]
}

print(convertTemperature(36.5)) // [309.65000,97.70000]
print(convertTemperature(122.11)) // [395.26000,251.79800]

print(Unit(symbol: "£"))


let cold = Measurement(value: 0, unit: UnitTemperature.celsius)
let warm = Measurement(value: 99, unit: UnitTemperature.fahrenheit)

print(cold < warm) // true
print(cold == warm) // false
print(cold > warm) // false

print(cold + warm) // given in Kelvin


//let size = cold.converted(to: UnitArea.squareFeet) // error: cannot convert value of type 'UnitEnergy' to expected argument type 'UnitTemperature'

let formatter = MeasurementFormatter()
formatter.locale = Locale(identifier: "en_GB")

print(formatter.string(from: cold)) // 0°C

let formatterUSA = MeasurementFormatter()
formatterUSA.locale = Locale(identifier: "en_US")
formatterUSA.unitStyle = .long
print(formatterUSA.string(from: cold)) // 32 degrees Fahrenheit

