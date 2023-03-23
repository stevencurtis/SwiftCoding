//
//  ContentView.swift
//  TasksProject
//
//  Created by Steven Curtis on 15/03/2023.
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
