//
//  AppDataModel.swift
//  HorizontalCollection
//
//  Created by Steven Curtis on 25/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

enum FeatureReason: String {
    case pride = "PRIDE"
    case new = "NEW APP"
}

struct AppDataModel: Hashable {
    let identifier: UUID = UUID()

    let title: String
    let subtitle: String
    let smallImage: String
    let featureImage: String
    var inApp: Bool? = nil
    let featureReason: FeatureReason? = .pride
}
