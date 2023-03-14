//
//  ContentView.swift
//  MainActorProject
//
//  Created by Steven Curtis on 14/03/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = JokeViewModel()

    var body: some View {
        ZStack {
            switch viewModel.state {
            case .initial:
                Text("Tap to fetch joke")
            case .joke(let jokeString):
                Text(jokeString)
                    .frame(width: 200, height: 200)
            case .loading:
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            case .error(let error):
                Text(error.localizedDescription)
            }
//            if let joke = viewModel.jokeText {
//                Text(joke)
//                    .frame(width: 200, height: 200)
//            } else if viewModel.isLoading {
//                ProgressView()
//                    .progressViewStyle(CircularProgressViewStyle())
//            } else if let error = viewModel.error {
//                Text(error.localizedDescription)
//            } else {
//                Text("Tap to fetch joke")
//            }
        }
        .onTapGesture {
            Task {
                await viewModel.fetchJoke()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
