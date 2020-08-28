//
//  Constants.swift
//  ReduxSwift
//
//  Created by Steven Curtis on 02/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
import ReSwift

// The global application store, which is responsible for managing the appliction state.
let mainStore = Store<AppState>(
    reducer: appReducer,
    state: nil
)

