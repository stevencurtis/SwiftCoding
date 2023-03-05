//
//  AIFlashcardsApp.swift
//  AIFlashcards
//
//  Created by Steven Curtis on 20/02/2023.
//

import SwiftUI

@main
struct AIFlashcardsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(flashcards: flashcards)
        }
    }
}
