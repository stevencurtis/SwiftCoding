//
//  User.swift
//  MVVMNetworking
//
//  Created by Steven Curtis on 11/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

public struct User: Codable, Hashable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
