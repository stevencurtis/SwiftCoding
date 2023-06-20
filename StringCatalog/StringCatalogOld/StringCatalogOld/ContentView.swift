//
//  ContentView.swift
//  StringCatalogOld
//
//  Created by Steven Curtis on 20/06/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(NSLocalizedString(
                "Hello", comment: ""))
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.locale, .init(identifier: "fr"))
    }
}
