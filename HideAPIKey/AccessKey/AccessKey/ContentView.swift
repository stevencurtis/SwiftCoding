//
//  ContentView.swift
//  AccessKey
//
//  Created by Steven Curtis on 29/07/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("API_KEY: \(Constants.apiKey)")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
