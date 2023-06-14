//
//  ContentView.swift
//  EnvironmentPropertyWrapper
//
//  Created by Steven Curtis on 14/06/2023.
//

import SwiftUI

// Using colorScheme
//struct ContentView: View {
//    @Environment(\.colorScheme) var colorScheme
//
//    var body: some View {
//        Text("Hello, SwiftUI!")
//            .foregroundColor(colorScheme == .dark ? .white : .black)
//    }
//}

struct ContentView: View {
    @EnvironmentObject var settings: UserSettings

    var body: some View {
        Text("This is font size: \(settings.fontSize)")
            .font(.system(size: settings.fontSize))
    }
}

final class UserSettings: ObservableObject {
    @Published var fontSize: CGFloat = 32.0
}
