//
//  ViewModel.swift
//  ExampleGet
//
//  Created by Steven Curtis on 08/03/2021.
//

import Foundation

class ViewModel {
    enum Constants {
        static let urlString = "https://reqres.in/api/users?page=2"
    }
    init() { }
    
    func getData(completion: @escaping (Result<Users, Error>) -> Void) {
        guard let url = URL(string: Constants.urlString) else {return}
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            if let data = data, let decoded = try? decoder.decode(Users.self, from: data) {
                completion(.success(decoded))
            }
            completion(.failure(NSError(domain: "999", code: 99, userInfo: [:])))
        })
        task.resume()
    }
}
