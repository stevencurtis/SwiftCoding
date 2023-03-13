//
//  ContentView.swift
//  AsyncLetMultiJokes
//
//  Created by Steven Curtis on 13/03/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ImageViewModel()

    var body: some View {
        ZStack {
            if let joke = viewModel.jokesText {
                VStack {
                    Text(joke[0])
                    Text(joke[1])
                    Text(joke[2])
                }
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
