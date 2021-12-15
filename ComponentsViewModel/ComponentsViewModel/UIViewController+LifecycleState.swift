//
//  UIViewController+LifecycleState.swift
//  ComponentsViewModel
//
//  Created by Steven Curtis on 18/02/2021.
//

import UIKit

public extension UIViewController {
    enum LifecycleState: CaseIterable {
        case didLoad
        case willAppear
        case didAppear
        case willDisappear
        case didDisappear
    }
}
