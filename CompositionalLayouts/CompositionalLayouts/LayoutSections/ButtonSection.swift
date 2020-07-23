//
//  ButtonSection.swift
//  CompositionalLayouts
//
//  Created by Steven Curtis on 29/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

struct ButtonSection: LayoutSection {
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath, item: AnyHashable, position: Int) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: ButtonCollectionViewCell.self), for: indexPath) as? ButtonCollectionViewCell else {
                fatalError("Unable to create new cell") }
        if let item = item as? AppDataModel {
            cell.configure(with: item, final: position == 5)
        }
        return cell
    }
    
    var layoutSection: NSCollectionLayoutSection = {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(35))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(35))
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitem: item,
            count: 1)
        
        let footerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(10.0))

        let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)

        let section = NSCollectionLayoutSection(group: group)
        // gap at the top of the section
        section.contentInsets = NSDirectionalEdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 5)
        section.interGroupSpacing = 5
        
        return section
    }()
}
