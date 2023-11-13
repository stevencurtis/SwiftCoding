//
//  ContentView.swift
//  UIProject
//
//  Created by Steven Curtis on 27/10/2023.
//

import ComponentLibrary
import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        Text("Examples")
        SimpleButtonView(action: {
            print("button pressed")
        }, buttonText: "My Test Button")
    }
}

#Preview {
    ContentView()
}
