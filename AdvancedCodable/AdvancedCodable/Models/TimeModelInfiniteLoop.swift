//
//  TimeModelInfiniteLoop.swift
//  AdvancedCodable
//
//  Created by Steven Curtis on 01/08/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

struct TimeModelInfiniteLoop: Codable {
    var times: [TimeModel]
    init(from decoder: Decoder) throws {
        var times = [TimeModel]()
        var container = try decoder.unkeyedContainer()
        while !container.isAtEnd {
            if let route = try? container.decode(TimeModel.self) {
                times.append(route)
            }
        }
        self.times = times
    }
}
