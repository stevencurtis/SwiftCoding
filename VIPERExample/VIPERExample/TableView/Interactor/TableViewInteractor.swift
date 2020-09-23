//
//  Interactor.swift
//  VIPERExample
//
//  Created by Steven Curtis on 22/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
import NetworkLibrary

protocol TableViewInteractorProtocol {
    func getData()
    var presenter: TableViewPresenterProtocol? {set get}
}

class TableViewInteractor: TableViewInteractorProtocol {
    weak var presenter: TableViewPresenterProtocol?
    
    private var networkManager: AnyNetworkManager<URLSession>?
    
    convenience init() {
        self.init(networkManager: NetworkManager<URLSession>() )
    }
    
    required init<T: NetworkManagerProtocol>(networkManager: T) {
        self.networkManager = AnyNetworkManager(manager: networkManager)
    }
    
    func getData() {
        if let url = URL(string: "https://jsonplaceholder.typicode.com/photos") {
            self.networkManager?.fetch(url: url, method: .get, completionBlock: {result in
                switch result {
                case .failure(let error):
                    // this error should be communicated with the user
                    print (error)
                case .success(let data):
                    let decoder = JSONDecoder()
                    let decoded = try! decoder.decode([Photo].self, from: data)
                    self.presenter?.dataDidFetch(photos: decoded)
                }
            })
        }
    }
}
