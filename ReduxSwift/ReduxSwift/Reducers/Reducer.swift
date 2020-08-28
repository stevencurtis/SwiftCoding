//
//  Reducer.swift
//  ReduxSwift
//
//  Created by Steven Curtis on 02/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
import ReSwift

// Evolve the AppState based on the actions received

func appReducer(action: Action, state: AppState?) -> AppState {
    // set up an initial state if the reducer isn't given a State
    var state = state ??
        AppState(
            person: [
                Person(name: "Paveen"),
                Person(name: "Karen")],
            currentIndex: 0)
    state.currentIndex = (state.currentIndex + 1) % state.person.count
    return state
}
