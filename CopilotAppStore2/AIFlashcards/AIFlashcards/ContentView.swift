//
//  ContentView.swift
//  AIFlashcards
//
//  Created by Steven Curtis on 20/02/2023.
//

import SwiftUI

struct Flashcard: Identifiable {
    let id = UUID()
    let question: String
    let answer: String
    
    init(question: String, answer: String) {
        self.question = question
        self.answer = answer
    }
}

struct ContentView: View {
    @State private var flashcards: [Flashcard]
    
    init(flashcards: [(String, String)]) {
        self.flashcards = flashcards.map { Flashcard(question: $0, answer: $1) }
    }
    
    var body: some View {
        VStack {
            Text("Flashcards")
                .font(.largeTitle)
                .padding()
            if let flashcard = flashcards.first {
                VStack {
                    Text(flashcard.question)
                        .font(.headline)
                        .padding()
                    AsyncImage(url: URL(string: "https://picsum.photos/200/300"))
                        .id(flashcard.id)
                    Text(flashcard.answer)
                        .font(.subheadline)
                        .padding()
                }
            } else {
                Text("No flashcards available")
                    .padding()
            }
            HStack {
                Button(action: {
                    if let currentFlashcard = flashcards.first {
                        flashcards.append(currentFlashcard)
                        flashcards.removeFirst()
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
        ContentView(flashcards: flashcards)
    }
}
