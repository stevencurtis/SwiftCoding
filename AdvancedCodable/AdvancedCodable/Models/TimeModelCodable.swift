//
//  TimeModelCodable.swift
//  AdvancedCodable
//
//  Created by Steven Curtis on 13/09/2022.
//  Copyright © 2022 Steven Curtis. All rights reserved.
//

import Foundation

struct TimeModelCodable: Codable {
    var times: [TimeModel]
    init(from decoder: Decoder) throws {
        var times = [TimeModel]()
        var container = try decoder.unkeyedContainer()
        while !container.isAtEnd {
            if let route = try? container.decode(TimeModel.self) {
                times.append(route)
            }
            else {
                _ = try? container.decode(DummyCodable.self)
            }
        }
        self.times = times
    }
}

private struct DummyCodable: Codable {}
