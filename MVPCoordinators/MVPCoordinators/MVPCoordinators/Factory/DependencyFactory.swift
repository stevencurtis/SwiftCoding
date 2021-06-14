//
//  DependencyFactory.swift
//  MVPCoordinators
//
//  Created by Steven Curtis on 07/05/2021.
//

import Foundation

protocol Factory {
    func makeInitialViewController(coordinator: ProjectCoordinator) -> MenuViewController
    func makeDetailViewController(coordinator: ProjectCoordinator, data: String) -> DetailViewController
}

class DependencyFactory: Factory {
    func makeDetailViewController(coordinator: ProjectCoordinator, data: String) -> DetailViewController {
        let viewController = DetailViewController(data: data)
        let presenter = DetailPresenter(view: viewController)
        viewController.set(presenter: presenter)
        return viewController
    }
    
    func makeInitialViewController(coordinator: ProjectCoordinator) -> MenuViewController {
        let viewController = MenuViewController()
        let presenter = MenuPresenter(coordinator: coordinator, view: viewController)
        viewController.set(presenter: presenter)
        return viewController
    }
    
    struct Dependencies {
        // this can be used for Network Managers, and similar
    }
    
    var dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeInitialCoordinator() -> ProjectCoordinator {
        let coordinator = ProjectCoordinator(factory: self)
        return coordinator
    }
}
