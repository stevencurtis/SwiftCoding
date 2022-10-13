//
//  AutoComplete.swift
//  PostcodeLookup
//
//  Created by Steven Curtis on 23/04/2021.
//

import Foundation

struct Autocomplete: Codable {
    let status : Int
    let result: [String]
}
