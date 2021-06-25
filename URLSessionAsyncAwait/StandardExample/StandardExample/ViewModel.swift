//
//  ViewModel.swift
//  StandardExample
//
//  Created by Steven Curtis on 22/06/2021.
//

import Foundation

class ViewModel {
    init() { }
    
    var closure: ((Users) -> Void)?
    
    func retrieveUsers(from url: URL) {
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: { [weak self] data, response, _ in
            guard let data = data,
                  let httpResponse = response as? HTTPURLResponse,
                  200..<300 ~= httpResponse.statusCode
            else { return }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            if let decoded = try? decoder.decode(Users.self, from: data) {
                self?.closure?(decoded)
            }
        })
        task.resume()
    }
    
}
