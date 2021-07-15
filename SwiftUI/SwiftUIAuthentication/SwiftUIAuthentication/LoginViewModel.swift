//
//  LoginViewModel.swift
//  SwiftUIAuthentication
//
//  Created by Steven Curtis on 19/11/2020.
//

import Foundation
import NetworkLibrary
import SwiftUI

class LoginViewModel: ObservableObject {

    @Published var username: String = "" // "eve.holt@reqres.in"
    @Published var password: String = "" // "cityslicka"
    @Published var loading: Bool = false
    @Published var login: Bool = false
    
    private var anyNetworkManager: AnyNetworkManager<URLSession>

    init<T: NetworkManagerProtocol>(networkManager: T) {
        self.anyNetworkManager = AnyNetworkManager(manager: networkManager)
    }
    
    func loginNetworkCall() {
        let data: [String : Any] = ["email": username, "password": password]
        self.loading = true
        self.login = false
        anyNetworkManager.fetch(url: API.login.url, method: .post(body: data), completionBlock: {[weak self] res in
            switch res {
            case .success(let data):
                let decoder = JSONDecoder()
                if let _ = try? decoder.decode(Login.self, from: data) {
                    DispatchQueue.main.async {
                        self?.login = true
                    }
                } else {
                    // potential here to update the view with an error
                }
            case .failure(let error):
                // potential here to update the view with an error
                print ("Error \(error)")
            }
            DispatchQueue.main.async {
                self?.loading = false
            }
        })
    }
}
