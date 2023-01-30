//  Created by Steven Curtis

import Foundation

struct EndPointModel: Codable {
    let products: [Products]
    let title: String
    let product_count: Int
}

struct Products: Codable {
    let id: String
    let name: String
    let price: String
    let image: String
}
