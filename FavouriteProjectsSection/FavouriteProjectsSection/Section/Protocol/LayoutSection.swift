//
//  LayoutSection.swift
//  FavouriteProjectsSection
//
//  Created by Steven Curtis on 15/03/2021.
//

import UIKit

protocol LayoutSection {
    var title: String { get set }
    var layoutSection: NSCollectionLayoutSection {get}
    func configureCell(collectionView: UICollectionView,
                       indexPath: IndexPath,
                       item: AnyHashable,
                       position: Int
    ) -> UICollectionViewCell
    func header(collectionView: UICollectionView,
                indexPath: IndexPath,
                title: String,
                buttonTitle: String?,
                action: @escaping (Int) -> Void
    ) -> UICollectionReusableView
}

