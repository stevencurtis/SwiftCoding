//
//  QuickLinksSection.swift
//  CompositionalLayouts
//
//  Created by Steven Curtis on 29/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

struct QuickLinksSection: LayoutSection {
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath, item: AnyHashable, position: Int) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: LinkCollectionViewCell.self), for: indexPath) as? LinkCollectionViewCell else {
                fatalError("Unable to create new cell") }
        if let item = item as? LinkDataModel {
            cell.configure(with: item, final: position == 5)
        }
        return cell
    }
    
    func header(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView? {
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: String(describing: TitleSupplementaryView.self),
            for: indexPath)
        if let hdr = header as? TitleSupplementaryView {
            hdr.configure(with: HeaderContent(title: "Quick Links", visibleButton: false, subtitle: ""))
            hdr.titleButtonAction = {
                print ("Clicked the following indexPath:", indexPath)
            }
        }
        return header
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

        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(22))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }()
}
