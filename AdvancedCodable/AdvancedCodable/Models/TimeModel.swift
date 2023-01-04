//
//  TimeModel.swift
//  AdvancedCodable
//
//  Created by Steven Curtis on 31/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

struct TimeModel: Codable {
    let timeStamp: Date
    let uniqueKey: String
    
    enum CodingKeys: String, CodingKey {
      case timeStamp = "timestamp"
        case uniqueKey = "uniqueKey"
    }
}

extension JSONDecoder {
    
    static var snakeCaseISO8601Date: JSONDecoder = {
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      decoder.dateDecodingStrategy = .iso8601
      return decoder
    }()
    
  static var snakeCaseMillisecondsISO8601Date: JSONDecoder = {
    let decoder = JSONDecoder()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    decoder.dateDecodingStrategy = .formatted(dateFormatter)
    return decoder
  }()
}
