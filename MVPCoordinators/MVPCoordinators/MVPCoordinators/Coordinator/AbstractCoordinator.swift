//
//  AbstractCoordinator.swift
//  MVPCoordinators
//
//  Created by Steven Curtis on 07/05/2021.
//

import Foundation

protocol AbstractCoordinator {
    func addChildCoordinator(_ coordinator: AbstractCoordinator)
    func removeAllChildCoordinatorsWith<T>(type: T.Type)
    func removeAllChildCoordinators()
}
