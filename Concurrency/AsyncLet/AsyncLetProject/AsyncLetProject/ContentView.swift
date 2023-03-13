//
//  ContentView.swift
//  AsyncLetProject
//
//  Created by Steven Curtis on 13/03/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = JokeViewModel()

    var body: some View {
        ZStack {
            if let joke = viewModel.jokeText {
                Text(joke)
                    .frame(width: 200, height: 200)
            } else if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else if let error = viewModel.error {
                Text(error.localizedDescription)
            } else {
                Text("Tap to fetch joke")
            }
        }
        .onTapGesture {
            Task {
                // await only required for the async let version of this code
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
