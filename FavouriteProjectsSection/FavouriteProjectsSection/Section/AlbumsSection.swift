//
//  AlbumsSection.swift
//  FavouriteProjectsSection
//
//  Created by Steven Curtis on 22/02/2021.
//

import UIKit

struct AlbumsSection: LayoutSection {
    var title: String
    
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath, item: AnyHashable, position: Int) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(
                describing: SongCollectionViewCell.self
            ),
            for: indexPath
        ) as? SongCollectionViewCell else {
            fatalError("Unable to create new cell") }
        if let item = item as? Favourites {
            cell.configure(with: item, onTap: { print("tap it") } )
        }
        return cell
    }
     
     var layoutSection: NSCollectionLayoutSection = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalWidth(0.33))
          let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150))
          let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

          let section = NSCollectionLayoutSection(group: group)
          section.orthogonalScrollingBehavior = .groupPagingCentered
          
          let headerSize = NSCollectionLayoutSize(
              widthDimension: .fractionalWidth(1.0),
              heightDimension: .estimated(100)
          )
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
          section.boundarySupplementaryItems = [sectionHeader]
          return section
     }()
     
     func header(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        title: String,
        buttonTitle: String?,
        action: @escaping (Int) -> ()
     ) -> UICollectionReusableView {
          let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: TitleSupplementaryView.self), for: indexPath)
          if let hdr = header as? TitleSupplementaryView {
            hdr.configure(
                with: .init(
                    title: title
//                    ,
//                    button: .init(action: {}, icon: "")
                )
              )
              hdr.titleButtonAction = {}
          }
          return header
     }
}
