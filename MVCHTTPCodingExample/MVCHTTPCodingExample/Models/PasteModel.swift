//
//  PasteModel.swift
//  CustomTabBarSimpleAPI
//
//  Created by Steven Curtis on 28/03/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation

class PasteModel : Codable {
    let id: String
    let source: String
    let title: String?
    let date: String?
    let emailCount: Int
    
    private enum CodingKeys: String, CodingKey {
        case id = "Id"
        case source = "Source"
        case title = "Title"
        case date = "Date"
        case emailCount = "EmailCount"
    }

}

