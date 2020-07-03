//
//  MainViewController.swift
//  UICollectionViewLists
//
//  Created by Steven Curtis on 03/07/2020.
//

import UIKit

class MainViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    // The snapshot is avaliable throughout the ViewController
    var snapshot = NSDiffableDataSourceSnapshot<Section, String>()

    // this is the initial data, the current data state will be set in the snapshot
    var data = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
    
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the UICollectionView
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        collectionView.delegate = self

        let registrationUICollectionViewListCell = UICollectionView.CellRegistration<UICollectionViewListCell, String> { (cell, indexPath, item) in
            var content = cell.defaultContentConfiguration()
            content.text = "\(item)"
            cell.contentConfiguration = content
            cell.trailingSwipeActionsConfiguration = UISwipeActionsConfiguration(
                actions: [UIContextualAction(
                    style: .destructive,
                    title: "Delete",
                    handler: { [weak self] _, _, completion in
                        guard let self = self else {return}
                        self.snapshot.deleteItems([item])
                        self.dataSource.apply(self.snapshot, animatingDifferences: false)
                        completion(true)
                    }
                )]
            )
        }

        let registrationCustomListCell = UICollectionView.CellRegistration<BasicCollectionViewCell, String> { (cell, indexPath, item) in
            cell.updateWithText(item)
            
            (cell as UICollectionViewListCell).trailingSwipeActionsConfiguration = UISwipeActionsConfiguration(
                actions: [UIContextualAction(
                    style: .destructive,
                    title: "Delete",
                    handler: { [weak self] _, _, completion in
                        guard let self = self else {return}
                        self.snapshot.deleteItems([item])
                        self.dataSource.apply(self.snapshot, animatingDifferences: false)
                        completion(true)
                    }
                )]
            )
            
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: String) -> UICollectionViewCell? in

            if indexPath.row % 2 == 0 {
                return collectionView.dequeueConfiguredReusableCell(using: registrationUICollectionViewListCell, for: indexPath, item: identifier)

            } else {
                return collectionView.dequeueConfiguredReusableCell(using: registrationCustomListCell, for: indexPath, item: identifier)
            }
        }

        snapshot.appendSections([.main])
        snapshot.appendItems(Array(data))
        dataSource.apply(snapshot, animatingDifferences: false)
   }
    
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        return UICollectionViewCompositionalLayout.list(using: config)
    }

}


extension MainViewController: UICollectionViewDelegate {}

