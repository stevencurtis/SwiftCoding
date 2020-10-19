//
//  ViewModel.swift
//  MVVMDI
//
//  Created by Steven Curtis on 14/10/2020.
//

import Foundation
import NetworkLibrary

class ViewModel{
    var network: AnyNetworkManager<URLSession>?
    
    required init<T: NetworkManagerProtocol>(networkManager: T) {
        self.network = AnyNetworkManager(manager: networkManager)
    }
    
    func getData() {
        let str = URL(string: "https://jsonplaceholder.typicode.com/todos/")!
        network!.fetch(url: str, method: .get, completionBlock: {result in
            switch result {
            case.failure(let error):
                print (error)
            case .success(let data):
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                    if let jsonDict = jsonObject as? NSDictionary {
                        print (jsonDict)
                    }
                    if let jsonArray = jsonObject as? NSArray {
                        print (jsonArray)
                    }
                } catch {
                    // error handling
                }
            }
        })
    }
}
