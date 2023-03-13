//
//  ImageViewModel.swift
//  AsyncLetMultiJokes
//
//  Created by Steven Curtis on 13/03/2023.
//

import SwiftUI

@MainActor
final class JokeViewModel: ObservableObject {
    @Published var jokesText: [String]?
    @Published var isLoading = false
    @Published var error: Error?
    
    func fetchJoke() async {
        do {
            isLoading = true
            async let firstJoke = getJoke()
            async let secondJoke = getJoke()
            async let thirdJoke = getJoke()
            jokesText = try await [firstJoke, secondJoke, thirdJoke]
            isLoading = false
        } catch {
            isLoading = false
            self.error = error
        }
    }
    
    private func getJoke() async throws -> String {
        let url = URL(string: "https://api.chucknorris.io/jokes/random")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        
        let result = try decoder.decode(Joke.self, from: data)
        return result.value
    }
}

struct Joke: Codable {
    let value: String
}
