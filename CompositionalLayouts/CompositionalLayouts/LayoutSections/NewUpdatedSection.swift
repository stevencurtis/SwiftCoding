//
//  NewUpdatedSection.swift
//  CompositionalLayouts
//
//  Created by Steven Curtis on 29/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

struct NewUpdatedSection: LayoutSection {
    static let rows = 2
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath, item: AnyHashable, position: Int) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: NewUpdatedCollectionViewCell.self), for: indexPath) as? NewUpdatedCollectionViewCell else {
                fatalError("Unable to create new cell") }
        if let item = item as? AppDataModel {
            cell.configure(with: item, final: position % NewUpdatedSection.rows != 0)
        }
        return cell
    }
    
    func header(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView? {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: TitleSupplementaryView.self), for: indexPath)
        if let hdr = header as? TitleSupplementaryView {
            hdr.configure(with: HeaderContent(
                title: "New and Updated in June",
                visibleButton: true,
                subtitle: ""))
            hdr.titleButtonAction = {
                print ("returned", indexPath)
            }
        }
        return header
    }
    
    var layoutSection: NSCollectionLayoutSection = {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(100))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.88),
            heightDimension: .absolute(210))
        
        // if out specify the number it overrides the one it itemSize
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitem: item, count: NewUpdatedSection.rows)
        // space between the items
        //group.interItemSpacing = .fixed(CGFloat(0))
        
        // header
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(22))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .groupPagingCentered
        return section
    }()
}
