//
//  ContentView.swift
//  SwiftMacros
//
//  Created by Steven Curtis on 21/06/2023.
//

import SwiftUI
import WWDC

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Text(#stringify(2 + 3).1)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
