//
//  ContentView.swift
//  StateExample
//
//  Created by Steven Curtis on 15/06/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var isButtonPressed = false

    var body: some View {
        Button(action: {
            isButtonPressed.toggle()
        }) {
            Text(isButtonPressed ? "Button is pressed" : "Button is not pressed")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
