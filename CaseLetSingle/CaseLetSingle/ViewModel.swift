//
//  ViewModel.swift
//  CaseLetSingle
//
//  Created by Steven Curtis on 02/07/2021.
//

import Foundation

class NetworkError: Error {}

class ViewModel {
    init() { }
    
    var closure: ((Result<Users, Error>) -> Void)?
    
    func retrieveUsers(from url: URL) {
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: { [weak self] data, response, _ in
            guard let data = data,
                  let httpResponse = response as? HTTPURLResponse,
                  200..<300 ~= httpResponse.statusCode
            else {
                self?.closure?(.failure(NetworkError()))
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            if let decoded = try? decoder.decode(Users.self, from: data) {
                self?.closure?(.success(decoded))
            }
        })
        task.resume()
    }
}
