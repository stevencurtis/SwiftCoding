//
//  ViewModel.swift
//  DependencyInversion
//
//  Created by Steven Curtis on 20/01/2023.
//

import Foundation

class ViewModel {
    private var anyNetworkManager: AnyNetworkManager<URLSession>?

    var resultClosure: ((Data) -> ())?
    init<T: NetworkManagerProtocol> (
        networkManager: T
    ) {
        self.anyNetworkManager = AnyNetworkManager(manager: networkManager)
    }
    
    func fetch() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
        
        anyNetworkManager?.fetch(url: url, method: .get, completionBlock: { [weak self] data in
            switch data {
            case .success(let data):
                self?.resultClosure?(data)
            case .failure:
                break
            }
        })
    }
}
