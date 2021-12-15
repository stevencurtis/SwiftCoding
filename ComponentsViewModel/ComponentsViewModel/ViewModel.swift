//
//  ViewModel.swift
//  ComponentsViewModel
//
//  Created by Steven Curtis on 17/02/2021.
//

import UIKit
import Combine

class ViewModel {
    
    @Published private(set) var labelModel: Label.Model = .init()
    
    func didChange(state: UIViewController.LifecycleState) {
        switch state {
        case .didLoad:
            labelModel = .init(text: "test")
            break
        default: break
        }
    }
}
