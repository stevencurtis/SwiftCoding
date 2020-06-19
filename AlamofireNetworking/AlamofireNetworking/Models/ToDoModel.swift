//
//  ToDoModel.swift
//  AlamofireNetworking
//
//  Created by Steven Curtis on 18/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

struct ToDoModel: Codable {
    let completed: Bool
    let id: Int
    let title: String
    let userId: Int
}
