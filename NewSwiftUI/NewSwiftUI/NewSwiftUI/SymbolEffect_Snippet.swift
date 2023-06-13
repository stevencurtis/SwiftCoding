//
//  SymbolEffect_Snippet.swift
//  NewSwiftUI
//
//  Created by Steven Curtis on 07/06/2023.
//

import SwiftUI

struct SymbolEffect_Snippet: View {
    @State private var downloadCount = -2
    @State private var isPaused = false

    var scaleUpActive: Bool {
        (downloadCount % 2) == 0
    }
    var isHidden: Bool { scaleUpActive }
    var isShown: Bool { scaleUpActive }
    var isPlaying: Bool { scaleUpActive }

    var body: some View {
        ScrollView {
            VStack(spacing: 48) {
                Image(systemName: "rectangle.inset.filled.and.person.filled")
                    .symbolEffect(.pulse)
                    .frame(maxWidth: .infinity)
                Image(systemName: "arrow.down.circle")
                    .symbolEffect(.bounce, value: downloadCount)
                Image(systemName: "wifi")
                    .symbolEffect(.variableColor.iterative.reversing)
                Image(systemName: "bubble.left.and.bubble.right.fill")
                    .symbolEffect(.scale.up, isActive: scaleUpActive)
                Image(systemName: "cloud.sun.rain.fill")
                    .symbolEffect(.disappear, isActive: isHidden)
                Image(systemName: isPlaying ? "play.fill" : "pause.fill")
                    .contentTransition(.symbolEffect(.replace.downUp))
            }
            .padding()
        }
        .font(.system(size: 64))
        .frame(maxWidth: .infinity)
        .symbolRenderingMode(.multicolor)
        .preferredColorScheme(.dark)
        .task {
            do {
                while true {
                    try await Task.sleep(for: .milliseconds(1500))
                    if !isPaused {
                        downloadCount += 1
                    }
                }
            } catch {
                print("exiting")
            }
        }
    }
}

#Preview {
    SymbolEffect_Snippet()
}
