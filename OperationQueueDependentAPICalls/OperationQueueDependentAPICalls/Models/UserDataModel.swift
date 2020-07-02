//
//  UserDataModel.swift
//  OperationQueueDependentAPICalls
//
//  Created by Steven Curtis on 10/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

struct UserDataModel: Codable, Equatable {
    let id: Int
    let email: String
    let first_name: String
    let last_name: String
    let avatar: String
}
