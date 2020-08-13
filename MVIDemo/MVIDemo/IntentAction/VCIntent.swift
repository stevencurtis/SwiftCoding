//
//  VCIntent.swift
//  MVIDemo
//
//  Created by Steven Curtis on 30/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// Actions are another name for the Intent
// The interaction modifies the Intent that manipulates the model
class VCIntent {
    var viewController: ViewController?
    var reducer = Reducer()
    private let disposeBag = DisposeBag()

    // this is the "onNext()" action
    /// Not great that the Intent rewrites the model
    public func onNext() {
        let newState = reducer.getNext(store: mainStore)
        presentNewState(newState: newState)
    }
    
    // This would usually be taken care of by the REDUX framework, taking the
    // new state and representing it to the main store and informing the
    // observers
    private func presentNewState(newState: AppState) {
        mainStore.accept(newState)
    }
    
    // bind the intent to the view controller
    public func bind(to viewController: ViewController) {
        self.viewController = viewController
        mainStore.subscribe{ event in
            self.viewController?.update(with: event)
        }.disposed(by: disposeBag)
    }
}
