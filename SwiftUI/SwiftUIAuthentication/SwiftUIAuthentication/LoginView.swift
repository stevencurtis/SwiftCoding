//
//  LoginView.swift
//  SwiftUIAuthentication
//
//  Created by Steven Curtis on 19/11/2020.
//

import SwiftUI
import NetworkLibrary

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                AppBackgroundView()
                    .zIndex(0)
                if self.viewModel.loading {
                    ProgressView()
                        .zIndex(1)
                }
                VStack{
                    LoginText()
                    TextField("Username", text: self.$viewModel.username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        .autocapitalization(.none)
                    SecureField("Password", text: self.$viewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    Button("Login", action: loginAction)
                    NavigationLink(
                        destination: MenuView(),
                        isActive: self.$viewModel.login,
                        label: {}
                    )
                }
            }
        }
    }
    
    func loginAction() {
        viewModel.loginNetworkCall()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        let nm = MockNetworkManager(session: URLSession.shared)
        LoginView(viewModel: LoginViewModel(networkManager: nm))
    }
}

struct LoginText : View {
    var body: some View {
        return Text("Login")
            .font(.headline)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
    }
}

struct AppBackgroundView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.clear, .secondary]), startPoint: .top, endPoint: .bottomLeading).edgesIgnoringSafeArea(.all)
        }
    }
}
