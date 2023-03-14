//
//  ContentView.swift
//  HighCohesionSwiftUI
//
//  Created by Steven Curtis on 13/03/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: UserViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.userName)
            Button("Edit") {
                viewModel.showEditView.toggle()
            }
        }
        .sheet(isPresented: $viewModel.showEditView) {
            showEditUserView(viewModel: viewModel)
        }
    }
}

extension ContentView {
    private func showEditUserView(viewModel: UserViewModel) -> some View {
        Form {
            TextField("Name", text: $viewModel.userName)
            TextField("Email", text: $viewModel.userEmail)
            Button("Save") {
                viewModel.saveUser()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: .init(userStore: UserStore()))
    }
}
