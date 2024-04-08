//
//  ContentView.swift
//  VStackLazyVStack
//
//  Created by Steven Curtis on 13/03/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 10) {
                Text("Top View")
                Divider()
                Text("Bottom View")
            }
            LazyVStack(alignment: .center, spacing: 20) {
                ForEach(0..<10) { index in
                    Text("Row \(index)")
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
