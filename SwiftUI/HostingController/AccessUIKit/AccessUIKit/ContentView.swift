//
//  ContentView.swift
//  AccessUIKit
//
//  Created by Steven Curtis on 26/04/2021.
//

import SwiftUI

struct ContentView: View {
    var animals = ["🦒", "🦮", "🐖" , "🦔", "🦓", "🦢", "🦋"]
    @State private var isPresented = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(animals, id: \.self) { animal in
                        NavigationLink(
                            destination:
                                DetailView()
                        ) {
                            Text(animal)
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .navigationBarHidden(true)
                Button("Show View Controller") {
                    self.isPresented = true
                }.sheet(isPresented: $isPresented) {
                    CustomViewController(message: "Hello, World!")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
