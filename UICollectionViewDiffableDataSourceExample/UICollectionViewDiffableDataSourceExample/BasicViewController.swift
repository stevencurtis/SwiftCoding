//
//  ViewController.swift
//  UICollectionViewDiffableDataSourceExample
//
//  Created by Steven Curtis on 24/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class BasicViewController: UIViewController {
    enum Section: CaseIterable {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, SymbolModel>!
    var collectionView: UICollectionView!

    var symbols: [SymbolModel] = [
        SymbolModel(name: "square.and.pencil"),
        SymbolModel(name: "person"),
        SymbolModel(name: "car"),
        SymbolModel(name: "airplane"),
        SymbolModel(name: "command"),
        SymbolModel(name: "shift"),
        SymbolModel(name: "control"),
        SymbolModel(name: "square.and.pencil"),
        SymbolModel(name: "person"),
        SymbolModel(name: "car"),
        SymbolModel(name: "airplane"),
        SymbolModel(name: "command"),
        SymbolModel(name: "shift"),
        SymbolModel(name: "control"),
        SymbolModel(name: "square.and.pencil"),
        SymbolModel(name: "person"),
        SymbolModel(name: "car"),
        SymbolModel(name: "airplane"),
        SymbolModel(name: "command"),
        SymbolModel(name: "shift"),
        SymbolModel(name: "control"),
        SymbolModel(name: "square.and.pencil"),
        SymbolModel(name: "person"),
        SymbolModel(name: "car"),
        SymbolModel(name: "airplane"),
        SymbolModel(name: "command"),
        SymbolModel(name: "shift"),
        SymbolModel(name: "control"),
        SymbolModel(name: "square.and.pencil"),
        SymbolModel(name: "person"),
        SymbolModel(name: "car"),
        SymbolModel(name: "airplane"),
        SymbolModel(name: "command"),
        SymbolModel(name: "shift"),
        SymbolModel(name: "control"),
        SymbolModel(name: "square.and.pencil"),
        SymbolModel(name: "person"),
        SymbolModel(name: "car"),
        SymbolModel(name: "airplane"),
        SymbolModel(name: "command"),
        SymbolModel(name: "shift"),
        SymbolModel(name: "control"),
        SymbolModel(name: "square.and.pencil"),
        SymbolModel(name: "person"),
        SymbolModel(name: "car"),
        SymbolModel(name: "airplane"),
        SymbolModel(name: "command"),
        SymbolModel(name: "shift"),
        SymbolModel(name: "control"),
        SymbolModel(name: "square.and.pencil"),
        SymbolModel(name: "person"),
        SymbolModel(name: "car"),
        SymbolModel(name: "airplane"),
        SymbolModel(name: "command"),
        SymbolModel(name: "shift"),
        SymbolModel(name: "control"),
        SymbolModel(name: "square.and.pencil"),
        SymbolModel(name: "person"),
        SymbolModel(name: "car"),
        SymbolModel(name: "airplane"),
        SymbolModel(name: "command"),
        SymbolModel(name: "shift"),
        SymbolModel(name: "control"),
        SymbolModel(name: "square.and.pencil"),
        SymbolModel(name: "person"),
        SymbolModel(name: "car"),
        SymbolModel(name: "airplane"),
        SymbolModel(name: "command"),
        SymbolModel(name: "shift"),
        SymbolModel(name: "control"),
        SymbolModel(name: "square.and.pencil"),
        SymbolModel(name: "person"),
        SymbolModel(name: "car"),
        SymbolModel(name: "airplane"),
        SymbolModel(name: "command"),
        SymbolModel(name: "shift"),
        SymbolModel(name: "control"),
        SymbolModel(name: "square.and.pencil"),
        SymbolModel(name: "person"),
        SymbolModel(name: "car"),
        SymbolModel(name: "airplane"),
        SymbolModel(name: "command"),
        SymbolModel(name: "shift"),
        SymbolModel(name: "control"),
        SymbolModel(name: "square.and.pencil"),
        SymbolModel(name: "person"),
        SymbolModel(name: "car"),
        SymbolModel(name: "airplane"),
        SymbolModel(name: "command"),
        SymbolModel(name: "shift"),
        SymbolModel(name: "control"),
    ]

    func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 150, height: 100)
        layout.scrollDirection = .vertical
        return layout
    }
    
    override func viewDidLoad() {
        let layout = createLayout()
        
        let frame = self.view.frame
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        
        let nib = UINib(nibName: "SymbolsCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "SymbolsCollectionViewCell")

        dataSource = UICollectionViewDiffableDataSource
            <Section, SymbolModel>(collectionView: collectionView) {
                (collectionView: UICollectionView, indexPath: IndexPath,
                country: SymbolModel) -> UICollectionViewCell? in
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: "SymbolsCollectionViewCell", for: indexPath) as? SymbolsCollectionViewCell else {
                        fatalError("Cannot create new cell") }
                cell.textLabel.text = self.symbols[indexPath.row].name
                cell.symbolImage.image = self.symbols[indexPath.row].icon
                return cell
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, SymbolModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(symbols, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: false)
        
        collectionView.delegate = self
        self.view.addSubview(collectionView)
        collectionView.backgroundColor = .lightGray
        self.view.backgroundColor = .lightGray
    }
}

extension BasicViewController: UICollectionViewDelegate{
    // Convert indexPath to itemIdentifier
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let identifier = dataSource.itemIdentifier(for: indexPath) {
            print (identifier)
        }
    }
}

