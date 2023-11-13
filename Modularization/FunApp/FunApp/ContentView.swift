//
//  ContentView.swift
//  FunApp
//
//  Created by Steven Curtis on 27/10/2023.
//

import ComponentLibrary
import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        Group {
            Text("Hello, World!")
            SimpleButtonView(action: {
                print("Press button")
            }, buttonText: "My Text")
        }
    }
}

#Preview {
    ContentView()
}
