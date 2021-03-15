//
//  Favourites.swift
//  FavouriteProjectsSection
//
//  Created by Steven Curtis on 22/02/2021.
//

import Foundation

struct FavouriteResponse: Decodable {
    let favourites: [Favourites]
}

struct Favourites: Decodable {
    let identifier: String
    let name: String
    let image: String
    
    init(identifier: String, name: String, image: String) {
        self.identifier = identifier
        self.name = name
        self.image = image
    }
}

extension Favourites: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    static func == (lhs: Favourites, rhs: Favourites) -> Bool {
        lhs.identifier == rhs.identifier
    }
}

