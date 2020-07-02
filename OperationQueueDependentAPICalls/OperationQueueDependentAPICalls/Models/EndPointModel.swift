//
//  EndPointModel.swift
//  BasicHTTPManager
//
//  Created by Steven Curtis on 07/03/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

public struct EndPointModel: Codable, Equatable {
    public var status: String?
    public var data : [String: String]?
    
    private enum CodingKeys: String, CodingKey {
        case status
        case data
    }
    
    public static func == (lhs: EndPointModel, rhs: EndPointModel) -> Bool {
        return lhs.status == rhs.status
    }
}
