//
//  Double+asTime.swift
//  CADisplayLinkExamples
//
//  Created by Steven Curtis on 07/12/2020.
//

import Foundation

extension Double {
    func asTime(style: DateComponentsFormatter.UnitsStyle) -> String {
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = style
        guard let formattedString = formatter.string(from: self) else { return "" }
        return formattedString
    }
}
