//
//  ContentView.swift
//  TasksProject
//
//  Created by Steven Curtis on 15/03/2023.
//

import SwiftUI

@MainActor
final class JokeViewModel: ObservableObject {
    @MainActor
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
            async let fetchedJoke = getJoke()
            let jokeText = try await fetchedJoke
            state = .joke(jokeText)
        } catch {
            state = .error(error)
        }
    }
    
    @MainActor
    private func getJoke() async throws -> String {
        let url = URL(string: "https://api.chucknorris.io/jokes/random")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        
        let result = try decoder.decode(JokeData.self, from: data)
        return result.value
    }
    
    func fetchJokeSync() {
        let task = Task {
            let joke = try? await getJoke()
        }
    }
}

struct JokeData: Codable {
    let value: String
}
