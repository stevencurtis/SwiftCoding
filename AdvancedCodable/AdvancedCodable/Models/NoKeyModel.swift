//
//  NoKeyModel.swift
//  AdvancedCodable
//
//  Created by Steven Curtis on 01/08/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

struct MyModel: Decodable {
    let array: [Any]

    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let firstString = try container.decode(String.self)
        let stringArray = try container.decode([String].self)
        array = [firstString, stringArray]
    }
}
