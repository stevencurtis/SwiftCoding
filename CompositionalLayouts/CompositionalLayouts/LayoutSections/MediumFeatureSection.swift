//
//  MediumFeatureSection.swift
//  CompositionalLayouts
//
//  Created by Steven Curtis on 26/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

struct MediumFeatureSection: LayoutSection {

    func configureCell(collectionView: UICollectionView, indexPath: IndexPath, item: AnyHashable, position: Int) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: AppMediumCollectionViewCell.self),
            for: indexPath) as? AppMediumCollectionViewCell else {
                fatalError("Unable to create new cell") }
        if let item = item as? AppDataModel {
            cell.configure(with: item, final: false)
        }
        return cell
    }
    
    func header(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView? {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: TitleSupplementaryView.self), for: indexPath)
        if let hdr = header as? TitleSupplementaryView {
            hdr.configure(
                with: HeaderContent(title: "5 Apps for the Little Ones",
                                    visibleButton: false,
                                    subtitle: ""))
            hdr.titleButtonAction = {
                print ("returned", indexPath)
            }
        }
        return header
    }
    
    var layoutSection: NSCollectionLayoutSection = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(325), heightDimension: .absolute(200))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(22))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        
         section.boundarySupplementaryItems = [sectionHeader]

        return section
    }()
}
