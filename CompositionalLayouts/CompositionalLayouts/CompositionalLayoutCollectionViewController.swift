//
//  CompositionalLayoutCollectionViewController.swift
//  CompositionalLayouts
//
//  Created by Steven Curtis on 02/07/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit


class CompositionalLayoutCollectionViewController: UICollectionViewController {
    enum Section: CaseIterable {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>!

    

}
