# Did You See This? A Measurement Class In Swift
## Look, I didn't know it was there

Difficulty: Beginner | **Easy** | Normal | Challenging<br/>

You might be aware that I'm not the biggest fan in the world of the https://leetcode.com website, as it encourages a reduction of programming into small pseudo-academic exercises.

However, I DO complete those challenges on occasion. This isn't just to be interview ready, it is also to give myself every opportunity to learn new things in the Swift language.

Today, just that happened.

# The Problem
You might well laugh at this one. It's a simple LeetCode problem and the website categorises this as "easy". It's number 2469, and is based on converting a temperature from Celsius to Kelvin and Fahrenheit.

You're even given the algorithm (it's really a sum) to convey how to derive Kelvin and Fahrenheit from Celsius.

- Kelvin = Celsius + 273.15
- Fahrenheit = Celsius * 1.80 + 32.00

which is no problem at all (right?)

However, I wanted to see if there is some other way of completing this challenge. 

# Measure Solution
If I think there 'should' be a better way of doing something in Swift, well there often is.

For some time (this actually was covered in WWDC 2016) `Foundation` has API that support Units and Measurement. Specifically this works in a locale-aware way for formatting and converting between units.

In the solution I'm able to use the `Measurement` `Struct` provided here (in the documentation https://developer.apple.com/documentation/foundation/measurement):

```swift
func convertTemperature(_ celsius: Double) -> [Double] {
    let celsius = Measurement(value: celsius, unit: UnitTemperature.celsius)
    let fahrenheit = celsius.converted(to: UnitTemperature.fahrenheit)
    let kelvin = celsius.converted(to: UnitTemperature.kelvin)
    return [kelvin.value, fahrenheit.value]
}
```

# Why does this matter?
It's a common feature of Apps to display data (clearly). We often want to display *international* versions of the data (that is formatting) and is something that should be expected from well-crafted software.

# Measurement and users
Swift uses a value-type to store measurements, specifically a `Struct`

```swift
struct Measurement<UnitType> where UnitType : Unit
```

and the documentation mentions that `Measurement` objects are initialized with `Unit` objects. 

These `Unit` objects are typically initialized with a `String` but the documentation (https://developer.apple.com/documentation/foundation/unit) has this rather wonderful titbit: `NSUnit` is intended for subclassing.

Indeed there is a list of dimensions that have already been subclassed

| NSDimension subclass            | Description                                       | Base unit                           |
|---------------------------------|---------------------------------------------------|-------------------------------------|
| UnitAcceleration                | Unit of measure for acceleration                  | meters per second squared (m/s²)    |
| UnitAngle                       | Unit of measure for planar angle and rotation     | degrees (°)                         |
| UnitArea                        | Unit of measure for area                          | square meters (m²)                  |
| UnitConcentrationMass           | Unit of measure for concentration of mass         | grams per liter (g/L)               |
| UnitDispersion                  | Unit of measure for dispersion                    | parts per million (ppm)             |
| UnitDuration                    | Unit of measure for duration of time              | seconds (sec)                       |
| UnitElectricCharge              | Unit of measure for electric charge               | coulombs (C)                        |
| UnitElectricCurrent             | Unit of measure for electric current              | amperes (A)                         |
| UnitElectricPotentialDifference | Unit of measure for electric potential difference | volts (V)                           |
| UnitElectricResistance          | Unit of measure for electric resistance           | ohms (Ω)                            |
| UnitEnergy                      | Unit of measure for energy                        | joules (J)                          |
| UnitFrequency                   | Unit of measure for frequency                     | hertz (Hz)                          |
| UnitFuelEfficiency              | Unit of measure for fuel efficiency               | liters per 100 kilometers (L/100km) |
| UnitIlluminance                 | Unit of measure for illuminance                   | lux (lx)                            |
| UnitInformationStorage          | Unit of measure for quantities of information     | bytes (b)                           |
| UnitLength                      | Unit of measure for length                        | meters (m)                          |
| UnitMass                        | Unit of measure for mass                          | kilograms (kg)                      |
| UnitPower                       | Unit of measure for power                         | watts (W)                           |
| UnitPressure                    | Unit of measure for pressure                      | newtons per square meter (N/m²)     |
| UnitSpeed                       | Unit of measure for speed                         | meters per second (m/s)             |
| UnitTemperature                 | Unit of measure for temperature                   | kelvin (K)                          |
| UnitVolume                      | Unit of measure for volume                        | liters (L)                          |

So this means we are welcome to create our own subclasses (great) and the `UnitTemperature` I used in the solution above is there!

This is represented in the following `Class`

```swift
class UnitTemperature : Dimension
```

# Fun With Measurements
Measurements conform to equatable. This is great, and means we can compare units.

```swift
let cold = Measurement(value: 0, unit: UnitTemperature.celsius)
let warm = Measurement(value: 99, unit: UnitTemperature.fahrenheit)

print(cold < warm) // true
print(cold == warm) // false
print(cold > warm) // false
```

All the conversion is *taken* care of. That's all kinds of awesome. 

What if we add two different measures?

```swift
cold + warm
```

This gives the result in `Kelvin`. This is because `Kelvin` is the base unit type for `UnitTemperature`. If we required any different units for the output here we could of course convert it.

We also get compile time errors if we attempt to convert a measure in a way that makes no sense.

```swift
let size = cold.converted(to: UnitArea.squareFeet) // error: cannot convert value of type 'UnitEnergy' to expected argument type 'UnitTemperature'
```

# Measurement Formatting
Ah, of course we can use a Formatter. Of course we can. We'll need to make sure we have set the correct `Locale` in order for the compiler to know *how* to correctly display the units. 

```swift
let formatter = MeasurementFormatter()
formatter.locale = Locale(identifier: "en_GB")
formatter.string(from: cold) // 0°C
```

So when we print the temperature in the UK, we get the friendly Celsius measurement.

If you're from across the pond, you can see this same information in American-friendly Fahrenheit.

```swift
let formatterUSA = MeasurementFormatter()
formatterUSA.locale = Locale(identifier: "en_US")
formatterUSA.unitStyle = .long
print(formatterUSA.string(from: cold)) // 32 degrees Fahrenheit
```

Look there! I've added the `unitStyle` property to the formatter. This means I've been able to display the long form of the temperature `// 32 degrees Fahrenheit` 

# Conclusion
It is inevitable that you have users from all around the world. They will want that data to be displayed in a way that suits them (not you). 

Remember, writing an App is all about the end user and not what you as a programmer would like to see!

I hope this helps someone out there! Thank you.

I hope this article has been of help to you. I've been using this code for some time, and I really do hope that it helps someone out!

Subscribing to Medium using [this link](https://medium.com/r/?url=https%3A%2F%2Fstevenpcurtis.medium.com%2Fmembership) shares some revenue with me.
You might even like to give me a hand by [buying me a coffee] (https://www.buymeacoffee.com/stevenpcuri).
If you've any questions, comments or suggestions please hit me up on [Twitter](https://twitter.com/stevenpcurtis)
