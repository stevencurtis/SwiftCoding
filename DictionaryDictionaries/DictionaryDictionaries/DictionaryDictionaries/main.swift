//
//  main.swift
//  DictionaryDictionaries
//
//  Created by Steven Curtis on 13/05/2021.
//

import Foundation

let developers: [String: [String]] = [ "Mr": ["Lim"], "Mrs": ["Smith", "Abayomi"], "Miss": ["González"], "Ms": ["Johnson", "Wilson"], "Other": [] ]
//print(developers)
var result: [String] = []
for developerPair in developers {
    if developerPair.value.isEmpty {
        result.append(developerPair.key)
        continue
    }
    for developer in developerPair.value {
        result.append("\(developerPair.key) \(developer)")
    }
}
print(result)

// reduce
print(
    developers.reduce(into: [String]()) { result, current in
        guard !current.value.isEmpty else { result.append(current.key); return }
        result.append(contentsOf: current.value.map { "\(current.key) \($0)" })
    }
)

// map
print(
    developers.map { element in
        return element.value.isEmpty ? ["\(element.key)"] : element.value.map { "\(element.key) \($0)" }
    }.flatMap{$0}
)


// flatMap
print(
    developers.flatMap { element -> [String] in
        guard !element.value.isEmpty else { return [element.key] }
        return element.value.map { "\(element.key) \($0)" }
    }
)
