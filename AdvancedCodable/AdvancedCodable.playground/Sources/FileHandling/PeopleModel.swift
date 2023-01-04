//
//  PeopleModel.swift
//  lldb
//
//  Created by Steven Curtis on 07/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

public struct PeopleModel: Codable {

    let name: String
    let job: [Job]
}

struct Job: Codable {
    let role: String
    let industry: String
}

extension PeopleModel: CustomDebugStringConvertible {
    public var debugDescription: String {return name}
}

extension PeopleModel: Equatable {
    public static func == (lhs: PeopleModel, rhs: PeopleModel) -> Bool {
        return lhs.name == rhs.name
    }
}
