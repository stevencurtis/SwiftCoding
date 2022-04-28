import UIKit

"hello".uppercased()

let arrayOfOptionals: [String?] = ["There", "Present", nil, "Not nil", nil, "Some"]

for value in arrayOfOptionals {
    // do something with the optional
    if let value = value {
        print(value)
    }
}

let uppercaseArray = arrayOfOptionals.map{ $0?.uppercased() }
print(uppercaseArray)

let arrayWithNoOptionals: [String] = arrayOfOptionals.compactMap { $0 }
print(arrayWithNoOptionals)
print(arrayWithNoOptionals.map{ $0.uppercased() })

