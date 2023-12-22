//
//  ContentView.swift
//  OpenEmailSwiftUI
//
//  Created by Steven Curtis on 07/11/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        VStack {
            Button("Click me to email", action: {
                viewModel.email()
            })
            Button("Click me to email with subject populated", action: {
                viewModel.emailWithSubject()
            })
            Button("Click me to email with subject and body populated", action: {
                viewModel.emailWithSubjectAndBody()
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
