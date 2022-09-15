//
//  ViewModel.swift
//  ServiceOriented
//
//  Created by Steven Curtis on 30/03/2021.
//

import Foundation
import NetworkLibrary

protocol ViewModelProtocol {
    func download()
    var dataClosure: ((Users?) -> Void)? { get set }
}

class ViewModel: ViewModelProtocol {
    
    private var anyNetworkManager: AnyNetworkManager<URLSession>?
    var dataClosure: ((Users?) -> Void)?
    
    init() {
        self.anyNetworkManager = AnyNetworkManager()
    }

    init<T: NetworkManagerProtocol>(
        networkManager: T
    ) {
        self.anyNetworkManager = AnyNetworkManager(manager: networkManager)
    }
    
    func download() {
        guard let url = URL(string: "https://reqres.in/api/users?page=2") else {return}
        anyNetworkManager?.fetch(url: url, method: .get(headers: [:], token: nil), completionBlock: {result in
            switch result {
            case .failure: break
            case .success(let data):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decoded = try? decoder.decode(Users.self, from: data)
                self.dataClosure?(decoded)
            }
        })
    }
}
