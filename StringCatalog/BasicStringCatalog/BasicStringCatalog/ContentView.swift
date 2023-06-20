//
//  ContentView.swift
//  BasicStringCatalog
//
//  Created by Steven Curtis on 20/06/2023.
//

import SwiftUI

struct ContentView: View {
    let hello: LocalizedStringResource = .init(stringLiteral: "Hello")
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(hello)
            Text(NSLocalizedString(
                "Hello", comment: ""))
            Text("\(10) $New Text Changed")
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .environment(\.locale, .init(identifier: "fr"))
}
