//  Created by Steven Curtis

import Foundation
@testable import CacheResponses

let testProduct = Products(id: "1", name: "Test Shirt", price: "Â£199", image: "https://media.endclothing.com/media/f_auto,q_auto,w_760,h_760/prodmedia/media/catalog/product/2/6/26-03-2018_gosha_rubchinskiyxadidas_copaprimeknitboostmidsneaker_yellow_g012sh12-220_ka_1.jpg")

func createTestProducts() -> [Products] {
    var products: [Products] = []
    for _ in 1...50 {
        let product = Products(id: "1", name: "Test Shirt", price: "Â£199", image: "https://media.endclothing.com/media/f_auto,q_auto,w_760,h_760/prodmedia/media/catalog/product/2/6/26-03-2018_gosha_rubchinskiyxadidas_copaprimeknitboostmidsneaker_yellow_g012sh12-220_ka_1.jpg")
        products.append(product)
    }
    return products
}

extension Products: Equatable {
    public static func == (lhs: Products, rhs: Products) -> Bool {
        return lhs.id == rhs.id
    }
}

struct UnexpectedNilError: Error {}

