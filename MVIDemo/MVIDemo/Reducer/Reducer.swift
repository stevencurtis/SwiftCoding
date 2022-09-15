//
//  Reducer.swift
//  MVIDemo
//
//  Created by Steven Curtis on 01/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// There will be a single reducer for the App, although this can be split for code readability reasons
// the reducer is responsible for evolving the application state based
// on the actions it receives
struct Reducer {
    // the reducer usually returns the AppState
    func getNext(store: BehaviorRelay<State>) -> AppState {
        let currentState = store.value
        return AppState(
            person: currentState.person,
            currentIndex: (currentState.currentIndex + 1) % currentState.person.count)
    }
}
