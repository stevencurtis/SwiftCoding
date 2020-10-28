//
//  Sandwich.swift
//  RecreateSandwiches
//
//  Created by Steven Curtis on 09/10/2020.
//

import Foundation

struct Sandwich: Identifiable {
    var id = UUID()
    var name: String
    var ingredientCount: Int
    var isSpicy: Bool = false
    
    var imageName: String { return name }
    var thumbnailName: String { return name + "-Thumbnail" }
}

let data = [
    Sandwich(name: "Caprese", ingredientCount: 4, isSpicy: false),
    Sandwich(name: "California Quinoa Burger", ingredientCount: 4, isSpicy: false),
]
