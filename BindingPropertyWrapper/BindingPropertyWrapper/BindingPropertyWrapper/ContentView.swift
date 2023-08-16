//
//  ContentView.swift
//  BindingPropertyWrapper
//
//  Created by Steven Curtis on 15/06/2023.
//

import SwiftUI

struct ContentView: View {
    @State var show = false

    var body: some View {
        NewView(show: $show)
    }
}

struct NewView: View {
    @Binding var show: Bool
    var body: some View {
        VStack {
            Button("Change show") {
                show = !show
            }
            Text(String(show))
        }
    }
}

struct ParentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
