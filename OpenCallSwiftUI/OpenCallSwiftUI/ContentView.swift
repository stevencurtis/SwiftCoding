//
//  ContentView.swift
//  OpenCallSwiftUI
//
//  Created by Steven Curtis on 18/10/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        VStack {
            Button("Click me to call", action: {
                viewModel.callNumber()
            })
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ViewModel())
    }
}
