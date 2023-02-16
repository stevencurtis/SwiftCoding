//
//  ViewModel.swift
//  DecodeJson
//
//  Created by Steven Curtis on 17/02/2021.
//

import Combine
import Foundation

final class ViewModel {
    var completion: ((Result<Users, Error>) -> Void)?
    
//    func download() {
//        guard let url = URL(string: "https://reqres.in/api/users?page=2") else {return}
//        let task = URLSession.shared.dataTask(with: url, completionHandler: { [weak self] data, response, _ in
//            guard let data = data,
//                  let httpResponse = response as? HTTPURLResponse,
//                  200..<300 ~= httpResponse.statusCode
//            else {return}
//            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
//            if let decoded = try? decoder.decode(Users.self, from: data) {
//                self?.completion?(.success(decoded))
//            }
//        })
//        task.resume()
//    }
//
    func download() -> Future<Users, Error> {
        Future { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        //                promise(.failure(NSError(domain: "", code: 0, userInfo: nil)))
                promise(
                    .success(
                        .init(
                            page: 0,
                            perPage: 0,
                            total: 0,
                            totalPages: 0,
                            data: [],
                            support: .init(url: "", text: "")
                        )
                    )
                )
            }
        }
//        Future { promise in
//            guard let url = URL(string: "https://reqres.in/api/users?page=2") else {return}
//            let task = URLSession.shared.dataTask(with: url, completionHandler: { [weak self] data, response, _ in
//                guard let data = data,
//                      let httpResponse = response as? HTTPURLResponse,
//                      200..<300 ~= httpResponse.statusCode
//                else {return}
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                if let decoded = try? decoder.decode(Users.self, from: data) {
//                    promise(.success(decoded))
//                }
//            })
//            task.resume()
//        }
    }
}
