//
//  Features.swift
//  RemoteFF
//
//  Created by Steven Curtis on 17/07/2024.
//

import Foundation

struct Features {
    @RemoteFeatureSwitch(key: "test", defaultValue: false)
    static var isNewFeatureEnabled: Bool
}
