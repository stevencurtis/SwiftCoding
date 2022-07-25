//
//  ListViewModel.swift
//  SnapshotTesting
//
//  Created by Steven Curtis on 24/09/2020.
//

import Foundation
import NetworkLibrary

class ListViewModel {
    
    let anyNetworkManager: AnyNetworkManager<URLSession>!
    
    convenience init() {
        self.init(manager: NetworkManager(session: URLSession.shared))
    }
    
    init<T: NetworkManagerProtocol>(manager: T) {
        anyNetworkManager = AnyNetworkManager<URLSession>(manager: manager)
    }
    
    private(set) var photos: [Photo] = []
    
    var update: (()->())?
    
    func fetchPhotos() {
        guard let url = API.photos.url else {return}
        anyNetworkManager.fetch(url: url, method: .get,
                                completionBlock: {[weak self] result in
                                    switch result {
                                    case .failure(let error):
                                        print ("error \(error)")
                                    case .success(let data):
                                        let decoder = JSONDecoder()
                                        let decoded = try? decoder.decode([Photo].self, from: data)
                                        self?.photos = decoded ?? []
                                        DispatchQueue.main.async {
                                            if let update = self?.update {
                                                update()
                                            }
                                        }
                                    }
                                })
    }
}
