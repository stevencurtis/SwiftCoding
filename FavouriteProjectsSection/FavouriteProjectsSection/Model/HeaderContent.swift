//
//  HeaderContent.swift
//  CompositionalLayouts
//
//  Created by Steven Curtis on 26/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

struct HeaderContent {
    let title: String
    let button: ButtonModel?
    var subtitle : String?
    
    init(title: String, button: ButtonModel? = nil, subtitle: String? = nil) {
        self.title = title
        self.button = button
        self.subtitle = subtitle
    }
}
