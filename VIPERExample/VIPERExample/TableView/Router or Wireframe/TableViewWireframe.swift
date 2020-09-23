//
//  TableViewWireframe.swift
//  VIPERExample
//
//  Created by Steven Curtis on 22/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit
import NetworkLibrary

protocol TableViewWireframeProtocol {
    func moveToDetail(view: TableViewControllerProtocol, withURL url: URL)
}

class TableViewWireframe: TableViewWireframeProtocol {
    func moveToDetail(view: TableViewControllerProtocol, withURL url: URL) {
        let detailViewController = DetailViewController()
        detailViewController.url = url
        DetailViewWireframe.createDetailModule(view: detailViewController)
        view.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    static func createViewModule (view: TableViewController) {
        let presenterInst = TableViewPresenter()
        view.presenter = presenterInst
        view.presenter?.wireframe = TableViewWireframe()
        view.presenter?.view = view
        view.presenter?.interactor = TableViewInteractor()
        view.presenter?.interactor?.presenter = presenterInst
    }
}
