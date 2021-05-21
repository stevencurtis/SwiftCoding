//
//  DetailPresenter.swift
//  MVP
//
//  Created by Steven Curtis on 07/05/2021.
//  Copyright © 2021 Steven Curtis. All rights reserved.
//

import Foundation

protocol DetailPresenterProtocol { }

class DetailPresenter: DetailPresenterProtocol {
    weak var view: DetailViewController?

    init(view: DetailViewController) {
        self.view = view
    }
}
