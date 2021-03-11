//
//  TableComponents.swift
//  CaseIterable
//
//  Created by Steven Curtis on 24/10/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation

enum AnimalStatus: String {
    case stable
    case angry
    case hungry
}

struct Animal {
    var name: String
    var status: AnimalStatus
}

enum Animals: String, CaseIterable {
    case dogs
    case elephants
    
    var items: [Animal] {
        switch self {
        case .dogs:
            return [
                Animal(name: "Colin", status: .stable)
            ]
        case .elephants:
        return [
            Animal(name: "Ahmed", status: .stable)
        ]
    }
}
}
