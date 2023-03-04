//
//  ContentView.swift
//  AsyncImageExample
//
//  Created by Steven Curtis on 21/02/2023.
//

import SwiftUI

struct ContentView: View {
    var url = URL(string: "https://picsum.photos/200/300")!
    var body: some View {
        VStack {
            AsyncImage(url: url)
            Text("Hello, world!")
            AsyncImage(url: url) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 150, height: 150)
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView("Loading...")
                case .success (let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                case .failure:
                    Text("Failed to load image")
                @unknown default:
                    Text("Unknown error")
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
