//
//  NextViewModel.swift
//  MVVMDI
//
//  Created by Steven Curtis on 15/10/2020.
//

import Foundation
import NetworkLibrary

class NextViewModel{
    var network: AnyNetworkManager<URLSession>?
    
    required init<T: NetworkManagerProtocol>(networkManager: T) {
        self.network = AnyNetworkManager(manager: networkManager)
    }
}
