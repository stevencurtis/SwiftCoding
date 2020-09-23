//
//  DetailViewPresenter.swift
//  VIPERExample
//
//  Created by Steven Curtis on 23/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation

class DetailViewPresenter {

    var wireframe: DetailViewWireframe?

    var view: DetailViewController?
    
    func loadData(url: URL) {
        print ("load data \(url)")
    }

}
