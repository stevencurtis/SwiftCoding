//
//  SymbolModel.swift
//  UICollectionViewDiffableDataSourceExample
//
//  Created by Steven Curtis on 24/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

struct SymbolModel: Hashable {
    let identifier: UUID = UUID()
    lazy var icon: UIImage? = {
        UIImage(systemName: name)
    }()
    let name: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func ==(lhs: SymbolModel, rhs: SymbolModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    func contains(filter: String?) -> Bool {
        guard let filter = filter, !filter.isEmpty  else { return true }
        let lowerCasedQuery = filter.lowercased()
        return name.lowercased().contains(lowerCasedQuery)
    }
}
