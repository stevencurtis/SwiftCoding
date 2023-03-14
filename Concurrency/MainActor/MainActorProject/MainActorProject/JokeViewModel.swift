//
//  JokeViewModel.swift
//  MainActorProject
//
//  Created by Steven Curtis on 14/03/2023.
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
        
        // makes the calling function wait
//        await MainActor.run {
//            print("AAA")
//            getJoke()
//        }

        let result = await MainActor.run { () -> Int in
            sleep(2)
            print("result is run on the main actor.")
            return 11
        }

        print(result)
        
        Task {
            let resultTwo = await MainActor.run { () -> Int in
                sleep(2)
                print("resultTwo is run on the main actor.")
                return 22
            }
        }
        
        print("resultTwo complete") // but you can't access resultTwo here
        
        let resultThree = Task { @MainActor in
            sleep(2)
            print("resultThree is run on the main actor.")
            return 33
        }

        print(await resultThree.value)
        print("resultThree complete") // will print after the previous print statement, as that awaits the result
        
        
        let resultFour = await MainActor.run { () -> Int in
            print(41)
            Task { @MainActor in
                print(42)
            }
            print(44)
            return 33
        }

        print(resultFour)
        print("resultFour complete")
        
        Task { @MainActor in try await getJoke() }

        // or better
        Task { try await getJoke() }
        
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
}

struct JokeData: Codable {
    let value: String
}
