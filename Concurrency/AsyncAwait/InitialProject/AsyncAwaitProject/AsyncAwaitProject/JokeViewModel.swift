//
//  JokeViewModel.swift
//  AsyncAwaitProject
//
//  Created by Steven Curtis on 16/03/2023.
//

import SwiftUI

final class JokeViewModel: ObservableObject {
    @Published var state: State = .initial
    
    enum State {
        case error(Error)
        case initial
        case joke(String)
        case loading
    }

    func fetchJoke() {
        state = .loading
        getJoke { data, _, _  in
            let decoder = JSONDecoder()
            guard let data = data,
                  let result = try? decoder.decode(JokeData.self, from: data)
            else { return }
            DispatchQueue.main.async {
                self.state = .joke(result.value)
            }
        }
    }
    
    private func getJoke(completion: @Sendable @escaping (Data?, URLResponse?, Error?) -> Void) {
        let url = URL(string: "https://api.chucknorris.io/jokes/random")!
        let request: URLRequest = .init(url: url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: completion)
        task.resume()
    }
}

struct JokeData: Codable {
    let value: String
}
