//
//  DetailPresenter.swift
//  MVPCoordinators
//
//  Created by Steven Curtis on 07/05/2021.
//

import Foundation

protocol DetailPresenterProtocol { }

class DetailPresenter:DetailPresenterProtocol  {
    weak var view: DetailViewController?

    init(view: DetailViewController) {
        self.view = view
    }
}
