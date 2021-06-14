//
//  RootCoordinator.swift
//  MVPCoordinators
//
//  Created by Steven Curtis on 07/05/2021.
//

import UIKit

/// Root Coordinator
protocol RootCoordinator: AnyObject {
    func start(_ navigationController: UINavigationController)
}
