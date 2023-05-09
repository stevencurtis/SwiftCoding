//
//  MainTabView.swift
//  Tabs
//
//  Created by Steven Curtis on 04/05/2023.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            ProductsView(userStore: testProfile, productStore: testProductsData)
                .tabItem {
                    Label("Products", systemImage: "cart.fill")
                }
                .tag(0)

            UserView(userStore: .init(user: .init(firstName: "Username", surname: "UserSurname")))
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
                .tag(1)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
