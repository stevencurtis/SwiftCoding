//
//  ContentView.swift
//  AIFlashcards
//
//  Created by Steven Curtis on 20/02/2023.
//

import SwiftUI

struct ContentView: View {
    // Initialize a state variable to keep track of the current flashcard index
    @State private var currentIndex = 0
    
    var body: some View {
        VStack {
            Text("Flashcards")
                .font(.largeTitle)
                .padding()
            Text(flashcards[currentIndex].0)
                .font(.headline)
                .padding()
            Text(flashcards[currentIndex].1)
                .font(.subheadline)
                .padding()
            HStack {
                Button(action: {
                    if currentIndex > 0 {
                        currentIndex -= 1
                    }
                }) {
                    Text("Prev")
                }
                Button(action: {
                    if currentIndex < flashcards.count - 1 {
                        currentIndex += 1
                    }
                }) {
                    Text("Next")
                }
            }
            .padding()
        }
    }
}

// SwiftUI preview for ContentView
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
