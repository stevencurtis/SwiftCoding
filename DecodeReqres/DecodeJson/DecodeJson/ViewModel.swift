//
//  ViewModel.swift
//  DecodeJson
//
//  Created by Steven Curtis on 17/02/2021.
//

import Foundation

class ViewModel {
    var completion: ((Users) -> Void)?
    
    func download() {
        guard let url = URL(string: "https://reqres.in/api/users?page=2") else {return}
        let task = URLSession.shared.dataTask(with: url, completionHandler: { [weak self] data, response, _ in
            guard let data = data,
                  let httpResponse = response as? HTTPURLResponse,
                  200..<300 ~= httpResponse.statusCode
            else {return}
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            if let decoded = try? decoder.decode(Users.self, from: data) {
                self?.completion?(decoded)
            }
        })
        task.resume()
    }
}
