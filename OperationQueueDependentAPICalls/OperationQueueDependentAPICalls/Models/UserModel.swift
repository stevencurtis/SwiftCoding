//
//  UserModel.swift
//  OperationQueueDependentAPICalls
//
//  Created by Steven Curtis on 10/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

struct UserModel: Codable, Equatable {
    let data: UserDataModel
    let ad: AdModel
    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
        lhs.data == rhs.data
    }
}
