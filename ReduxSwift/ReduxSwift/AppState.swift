//
//  AppState.swift
//  ReduxSwift
//
//  Created by Steven Curtis on 02/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
import ReSwift

struct AppState: StateType {
    var person : [Person]
    var currentIndex: Int
}
