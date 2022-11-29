//
//  PeopleModel.swift
//  AddFieldsToBackendResponse
//
//  Created by Steven Curtis on 13/09/2022.
//

import Foundation

struct PeopleModel: Codable {
    let name: String
    let email: String
    let job: [Job]
}

struct Job: Codable {
    let role: String
    let industry: String
}

extension PeopleModel: CustomDebugStringConvertible {
    var debugDescription: String { return name }
}

extension PeopleModel: Equatable {
    static func == (lhs: PeopleModel, rhs: PeopleModel) -> Bool {
        return lhs.name == rhs.name
    }
}

