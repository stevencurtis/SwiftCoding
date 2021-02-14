//
//  SwiftUIAuthenticationApp.swift
//  SwiftUIAuthentication
//
//  Created by Steven Curtis on 19/11/2020.
//

import SwiftUI
import NetworkLibrary

@main
struct SwiftUIAuthenticationApp: App {
    var body: some Scene {
        WindowGroup {
            let nm = NetworkManager(session: URLSession.shared)
            let viewModel = LoginViewModel(networkManager: nm)
            LoginView(viewModel: viewModel)
        }
    }
}
