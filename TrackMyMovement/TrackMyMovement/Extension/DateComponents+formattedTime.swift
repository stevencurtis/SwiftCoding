//
//  DateComponents+formattedTime.swift
//  TrackMyMovement
//
//  Created by Steven Curtis on 24/11/2020.
//

import Foundation

extension DateComponents {
    var formattedTime: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: self) ?? ""
    }
}
