//
//  Item.swift
//  MeetSwiftData
//
//  Created by Steven Curtis on 22/06/2023.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
