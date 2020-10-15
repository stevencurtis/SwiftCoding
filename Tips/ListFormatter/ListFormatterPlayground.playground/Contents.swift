import UIKit

let names = ["Livesh", "Romesh", "Chau", "Bella"]

var originalNamesString = ""
for name in names.enumerated() {
    if name.offset == names.count - 1
    {
        originalNamesString.append("and \(name.element)")
        
    }
    else
    {
        originalNamesString.append("\(name.element), ")
    }
}

print (originalNamesString)


let namesString = ListFormatter.localizedString(byJoining: names)
print(namesString)

let formatter = ListFormatter()
formatter.locale = Locale(identifier: "en_GB")

let ukNamesString = formatter.string(for: names)
print (ukNamesString ?? "")



let priceFormatter = NumberFormatter()
priceFormatter.locale = Locale(identifier: "en_GB")
priceFormatter.numberStyle = .currency

let currencyListformatter = ListFormatter()
currencyListformatter.itemFormatter = priceFormatter
currencyListformatter.locale = Locale(identifier: "en_GB")

let items = [1.3, 1.2, 9.4, 3.4]
let currencyString = currencyListformatter.string(for: items)
print (currencyString ?? "")



let dateFormatter = DateFormatter()
dateFormatter.locale = Locale(identifier: "en_GB")
dateFormatter.dateStyle = .long

let dateListformatter = ListFormatter()
dateListformatter.itemFormatter = dateFormatter
dateListformatter.locale = Locale(identifier: "en_GB")

let dates = [Date(timeIntervalSince1970: 1821546354), Date(timeIntervalSince1970: 1221546354), Date(timeIntervalSince1970: 721546354)]
let datesString = dateListformatter.string(for: dates)
print (datesString ?? "")


