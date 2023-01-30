//
//  ContentViewModel.swift
//  MVVMNetworking
//
//  Created by Steven Curtis on 11/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    @Published var users: [User] = []
    var res: AnyCancellable?
    private var networkManager: AnyNetworkManager<URLSession>?
    
    init() {
        self.networkManager = AnyNetworkManager(manager: NetworkManager(session: URLSession.shared))
        
        res = networkManager?.fetch(url: URL(string: "https://jsonplaceholder.typicode.com/posts/1")!, method: .get)
            .sink(receiveCompletion: {comp in
                print (comp)},
                  receiveValue: {
                    val in
                    let decode = JSONDecoder()
                    let decoded = try? decode.decode(User.self, from: val)
                    self.users = [decoded!]
            })
    }
}
