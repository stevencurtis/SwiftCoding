//
//  ImageViewModel.swift
//  AsyncLetProject
//
//  Created by Steven Curtis on 13/03/2023.
//

import SwiftUI

@MainActor
final class JokeViewModel: ObservableObject {
    @Published var jokeText: String?
    @Published var isLoading = false
    @Published var error: Error?

    //    func fetchJoke() async {
    //        do {
    //            isLoading = true
    //            async let fetchedJoke = getJoke()
    //            jokeText = try await fetchedJoke
    //            isLoading = false
    //        } catch {
    //            isLoading = false
    //            self.error = error
    //        }
    //    }
    
    //    private func getJoke() async throws -> String {
    //        let url = URL(string: "https://api.chucknorris.io/jokes/random")!
    //        let (data, _) = try await URLSession.shared.data(from: url)
    //        let decoder = JSONDecoder()
    //
    //        let result = try decoder.decode(Joke.self, from: data)
    //        return result.value
    //    }
    
    func fetchJoke() {
        isLoading = true
        Task {
            do {
                jokeText = try await getJoke()
            } catch {
                self.error = error
            }
            isLoading = false
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
