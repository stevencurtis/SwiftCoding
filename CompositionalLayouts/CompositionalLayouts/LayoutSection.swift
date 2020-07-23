//
//  LayoutSection.swift
//  CompositionalLayouts
//
//  Created by Steven Curtis on 26/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

protocol LayoutSection {
    var layoutSection: NSCollectionLayoutSection {get}
    func configureCell(collectionView: UICollectionView,
                       indexPath: IndexPath,
                       item: AnyHashable,
                       position: Int) -> UICollectionViewCell
    func header(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView?
}

extension LayoutSection {
    func header(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView? {
        return nil
    }
}
