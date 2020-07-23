//
//  AppsCompositionalLayout.swift
//  CompositionalLayouts
//
//  Created by Steven Curtis on 25/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class AppsCompositionalLayout: UICollectionViewController {
    enum Section: CaseIterable {
        case features
        case appSection
        case medium
        case new
        case links
        case buttons
        case terms
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>!
    
    // Derives the order of the sections
    lazy var sections: [LayoutSection] =
        [FeatureSection(),
         NewUpdatedSection(),
         MediumFeatureSection(),
         AppsSection(),
         QuickLinksSection(),
         ButtonSection(),
         TermsSection()
    ]
    
    override func viewDidLoad() {
        let frame = self.view.frame
        collectionView = UICollectionView(frame: frame, collectionViewLayout: myCollectionViewLayout)
        
        collectionView.register(UINib(nibName: String(describing: AppStandardCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: AppStandardCollectionViewCell.self))
        
        collectionView.register(UINib(nibName: String(describing: AppFeaturedCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: AppFeaturedCollectionViewCell.self))
        
        collectionView.register(TitleSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: TitleSupplementaryView.self))
        
        collectionView.register(UINib(nibName: String(describing: AppMediumCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: AppMediumCollectionViewCell.self))
        
        collectionView.register(UINib(nibName: String(describing: NewUpdatedCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: NewUpdatedCollectionViewCell.self))
        
        collectionView.register(LinkCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: LinkCollectionViewCell.self))
        
        collectionView.register(ButtonCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ButtonCollectionViewCell.self))
        
        collectionView.register(TermsCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: TermsCollectionViewCell.self))
        
        dataSource = UICollectionViewDiffableDataSource
            <Section, AnyHashable>(collectionView: collectionView) {
                (collectionView: UICollectionView,
                indexPath: IndexPath,
                app: AnyHashable) -> UICollectionViewCell? in
                
                return self.sections[indexPath.section].configureCell (
                    collectionView: collectionView,
                    indexPath: indexPath,
                    item: app,
                    position: indexPath.row)
        }
        
        configureHeader()
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        snapshot.appendSections([.appSection, .new, .medium, .features, .links, .buttons, .terms])
        snapshot.appendItems(symbols, toSection: .appSection)
        snapshot.appendItems(medium, toSection: .medium)
        snapshot.appendItems(featured, toSection: .features)
        snapshot.appendItems(newupdated, toSection: .new)
        snapshot.appendItems(quickLinks, toSection: .links)
        snapshot.appendItems(buttons, toSection: .buttons)
        snapshot.appendItems(terms, toSection: .terms)

        dataSource.apply(snapshot, animatingDifferences: false)

        collectionView.delegate = self
        collectionView.backgroundColor = .white
    }
    
    // boundary supplimentary heading
    lazy var myCollectionViewLayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            return self.sections[sectionIndex].layoutSection
        }
        return layout
    }()
    
    func configureHeader() {
        dataSource.supplementaryViewProvider = {
          (
          collectionView: UICollectionView,
          kind: String,
          indexPath: IndexPath)
            -> UICollectionReusableView? in
            return self.sections[indexPath.section].header(collectionView: collectionView, indexPath: indexPath)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupNavBar()
        super.viewDidAppear(animated)
    }
}


