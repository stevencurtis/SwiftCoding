//
//  MenuPresenter.swift
//  MVP
//
//  Created by Steven Curtis on 30/08/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import Foundation

@objc protocol MenuPresenterProtocol {
    var data: [String] { get }
    func buttonPressed()
    func showDetail(data: String)
}

class MenuPresenter: MenuPresenterProtocol {
    let data = ["a", "b", "c", "d"]
    weak var view: MenuViewController?
    
    @objc func buttonPressed() {
        print("Button Pressed")
    }
    
    init(view: MenuViewController) {
        self.view = view
    }
    
    func showDetail(data: String) {
        view?.navigationController?.pushViewController(DetailViewController(data: data), animated: true)
    }
}
