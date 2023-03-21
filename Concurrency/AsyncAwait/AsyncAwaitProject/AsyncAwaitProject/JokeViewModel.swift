//
//  JokeViewModel.swift
//  AsyncAwaitProject
//
//  Created by Steven Curtis on 16/03/2023.
//

import SwiftUI

@MainActor
final class JokeViewModel: ObservableObject {
    @Published var state: State = .initial
    
    enum State {
        case error(Error)
        case initial
        case joke(String)
        case loading
    }

    func fetchJoke() async {
        state = .loading
        do {
            let jokeText = try await getJoke()
            state = .joke(jokeText)
        } catch {
            state = .error(error)
        }
    }
    
    private func getJoke() async throws -> String {
        let url = URL(string: "https://api.chucknorris.io/jokes/random")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let result = try decoder.decode(JokeData.self, from: data)
        return result.value
    }
}

struct JokeData: Codable {
    let value: String
}
