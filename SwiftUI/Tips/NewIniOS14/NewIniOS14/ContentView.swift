//
//  ContentView.swift
//  NewIniOS14
//
//  Created by Steven Curtis on 23/06/2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: MultilineView()) {
                    Text("TextEditor")}
                NavigationLink(destination: ProgressExampleView()) {Text("ProgressView")}
                NavigationLink(destination: ProgressSpinner()) {Text("ProgressSpinner")}
                NavigationLink(destination: MapExampleView()) {Text("Map")}
                NavigationLink(destination: ChangeExampleView()) {Text("Changes")}
                Link("Google", destination: URL(string: "https://www.google.com")!)
                NavigationLink(destination: ColorExampleView()) {Text("Color Picker")}
                NavigationLink(destination: PageTabViewStyleExampleView()) {Text("PageTabViewStyle")}
                NavigationLink(destination: LazyVGridExampleView()) {Text("LazyVGridExampleView")}
            }
            .navigationBarTitle("New for iOS14")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
