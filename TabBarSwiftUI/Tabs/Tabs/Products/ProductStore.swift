//
//  ProductStore.swift
//  SwiftUIArchitecture
//
//  Created by Steven Curtis on 10/04/2023.
//

import Foundation

final class ProductsStore: ObservableObject {
    @Published var products: [Product]
    
    init(products: [Product] = []) {
        self.products = products
    }
}

let testProductsData = ProductsStore(products: [.test(name: "Beans", price: "$1")])

struct Product {
    let name: String
    let price: String
}

extension Product {
    static func test(name: String = "productName", price: String = "productPrice") -> Self {
        .init(name: name, price: price)
    }
}
