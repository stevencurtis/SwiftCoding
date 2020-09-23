//
//  Presenter.swift
//  VIPERExample
//
//  Created by Steven Curtis on 22/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

protocol TableViewPresenterProtocol: class {
    func moveToDetail(indexPath: IndexPath)
    func loadData()
    func dataDidFetch(photos: [Photo])
}

class TableViewPresenter: TableViewPresenterProtocol {
    
    var wireframe: TableViewWireframeProtocol?
    var view: TableViewControllerProtocol?
    var interactor: TableViewInteractorProtocol?

    var dataDownloaded = 0
    
    var photos: [Photo] = []
        
    func loadData() {
        interactor?.getData()
    }
    
    func dataDidFetch(photos: [Photo]) {
        self.photos = photos
        DispatchQueue.main.async {
            self.view?.refresh()
        }
    }
    
    func moveToDetail(indexPath: IndexPath) {
        if let view = view,
           let url = URL(string: photos[indexPath.row].url) {
            wireframe?.moveToDetail(view: view, withURL: url)
        }
    }
}
