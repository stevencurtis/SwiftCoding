//
//  MenuPresenter.swift
//  MVPCoordinators
//
//  Created by Steven Curtis on 07/05/2021.
//

import Foundation

@objc protocol MenuPresenterProtocol {
    var data: [String] { get }
    func buttonPressed()
    func showDetail(data: String)
}

class MenuPresenter {
    let data = ["a", "b", "c", "d"]
    weak private var view: MenuViewController?
    private var coordinator: ProjectCoordinator?
    
    @objc func buttonPressed() {
        print("Button Pressed")
    }
    
    init(coordinator: ProjectCoordinator, view: MenuViewController) {
        self.coordinator = coordinator
        self.view = view
    }
    
    func showDetail(data: String) {
        coordinator?.moveToDetail(withData: data)
    }
}

extension MenuPresenter: MenuPresenterProtocol { }
