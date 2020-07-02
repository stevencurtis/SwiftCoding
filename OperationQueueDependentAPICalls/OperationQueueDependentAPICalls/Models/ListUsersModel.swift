//
//  ListUsersModel.swift
//  OperationQueueDependentAPICalls
//
//  Created by Steven Curtis on 10/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

struct ListUsersModel: Codable, Equatable {
    static func == (lhs: ListUsersModel, rhs: ListUsersModel) -> Bool {
        lhs.data == rhs.data
    }
    
    let page: Int
    let per_page: Int
    let total: Int
    let total_pages: Int
    let data: [UserDataModel]
    let ad: AdModel
}


