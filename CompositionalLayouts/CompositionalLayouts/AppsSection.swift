//
//  AppsSection.swift
//  CompositionalLayouts
//
//  Created by Steven Curtis on 26/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

struct AppsSection: LayoutSection {
    static let rows = 3
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath, item: AnyHashable, position: Int) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: AppStandardCollectionViewCell.self), for: indexPath) as? AppStandardCollectionViewCell else {
                fatalError("Unable to create new cell") }

        if let item = item as? AppDataModel {
            cell.configure(with: item, final: position % AppsSection.rows == 2)
        }
        
        // unowned since we are CERTAIN that this VC is in memory when the closure is called
        cell.subscribeButtonAction = {
            print ("action")
        }
        return cell
    }
    
    func header(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView? {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: TitleSupplementaryView.self), for: indexPath)
        if let hdr = header as? TitleSupplementaryView {
            hdr.configure(
                with: HeaderContent(
                    title: "Hot Right Now",
                    visibleButton: true,
                    subtitle: "The apps you need this week"))
            hdr.titleButtonAction = {
                print ("Clicked this index:", indexPath)
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
            heightDimension: .absolute(300))
        
        // if out specify the number it overrides the one it itemSize
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitem: item, count: AppsSection.rows)
        
        // header
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(22))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        
        let sectionSideInset: CGFloat = 20
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: sectionSideInset, bottom: 0, trailing: sectionSideInset)
        
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }()
}
