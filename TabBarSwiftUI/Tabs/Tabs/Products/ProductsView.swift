//
//  ProductsView.swift
//  SwiftUIArchitecture
//
//  Created by Steven Curtis on 10/04/2023.
//

import SwiftUI

struct ProductsView: View {
    @ObservedObject var userStore: ProfileStore
    @ObservedObject var productStore: ProductsStore
    var body: some View {
        VStack(spacing: 10) {
            VStack {
                Text("Hello \(userStore.user?.firstName ?? "")")
                Text("Why not purchase one of the following items:")
            }
            VStack(alignment: .leading) {
                ForEach(productStore.products, id: \.name) { product in
                    Text(product.name)
                    Text(product.price)
                    Button("Buy") { }
                }
            }
        }
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView(
            userStore: testProfile,
            productStore: testProductsData
        )
    }
}
