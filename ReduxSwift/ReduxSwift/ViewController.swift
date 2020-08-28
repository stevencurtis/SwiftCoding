//
//  ViewController.swift
//  ReduxSwift
//
//  Created by Steven Curtis on 02/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit
import ReSwift

class ViewController: UIViewController, StoreSubscriber {
    
    // requirement of the StoreSubscriber protocol
    typealias StoreSubscriberStateType = AppState
    @IBOutlet weak var nameLabel: UILabel!
    
    // called when the AppState is updated
    func newState(state: AppState) {
        nameLabel.text = mainStore.state.person[mainStore.state.currentIndex].name
    }
        
    @IBAction func nextAction(_ sender: UIButton) {
        mainStore.dispatch(NextPerson())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // subscribe to state changes
        mainStore.subscribe(self)
    }

}
