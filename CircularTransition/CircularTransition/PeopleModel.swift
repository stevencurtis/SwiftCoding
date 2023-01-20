//
//  PeopleModel.swift
//  lldb
//
//  Created by Steven Curtis on 07/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

struct PeopleModel: Codable {
    let name: String
    let job: [Job]
    let image: String
}

struct Job: Codable {
    let role: String
    let industry: String
}

extension PeopleModel: CustomDebugStringConvertible {
    var debugDescription: String {return name}
}

extension PeopleModel: Equatable {
    static func == (lhs: PeopleModel, rhs: PeopleModel) -> Bool {
        return lhs.name == rhs.name
    }
}
