//
//  DetailViewWireframe.swift
//  VIPERExample
//
//  Created by Steven Curtis on 23/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

class DetailViewWireframe {
    
    static func createDetailModule (view: DetailViewController) {
        let presenter = DetailViewPresenter()
        
        view.presenter = presenter
        view.presenter?.view = view
        view.presenter?.wireframe = DetailViewWireframe()
    }
    
}
