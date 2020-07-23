//
//  TermsSection.swift
//  CompositionalLayouts
//
//  Created by Steven Curtis on 30/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

struct TermsSection: LayoutSection {
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath, item: AnyHashable, position: Int) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: TermsCollectionViewCell.self), for: indexPath) as? TermsCollectionViewCell else {
                fatalError("Unable to create new cell") }
        if let item = item as? AppDataModel {
            cell.configure(with: item, final: position == 5)
        }
        return cell
    }
    
    func header(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView? {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: TitleSupplementaryView.self), for: indexPath)
        if let hdr = header as? TitleSupplementaryView {
            hdr.configure(with: HeaderContent(title: "Quick Links", visibleButton: false, subtitle: ""))
            hdr.titleButtonAction = {
                print ("Clicked this Index: ", indexPath)
            }
        }
        return header
    }
    
    var layoutSection: NSCollectionLayoutSection = {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(50))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(50))
        
        // if out specify the number it overrides the one it itemSize
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitem: item,
            count: 1)
        
        // header
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(22))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        
        let footerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(10.0))

        let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)

        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }()
}
