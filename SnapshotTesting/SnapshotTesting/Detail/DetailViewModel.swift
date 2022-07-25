//
//  DetailViewModel.swift
//  SnapshotTesting
//
//  Created by Steven Curtis on 24/09/2020.
//

import Foundation
import NetworkLibrary

class DetailViewModel {
    let networkManager: AnyNetworkManager<URLSession>!
    
    let photo: Photo!
    
    convenience init(photo: Photo) {
        self.init(photo: photo, networkManager: NetworkManager(session: URLSession.shared))
    }
    
    
    init(photo: Photo, networkManager: NetworkManager<URLSession>) {
        self.photo = photo
        self.networkManager = AnyNetworkManager(manager: networkManager)
    }
}
