//
//  SearchableViewController.swift
//  UICollectionViewDiffableDataSourceExample
//
//  Created by Steven Curtis on 24/06/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import UIKit

class SearchableViewController: UIViewController {
    
    enum Section: CaseIterable {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, SymbolModel>!
    var collectionView: UICollectionView!

    var symbols: [SymbolModel] = []

    override func viewDidLoad() {
        symbols =  [
               SymbolModel(name: "square.and.pencil"),
               SymbolModel(name: "person"),
               SymbolModel(name: "car"),
               SymbolModel(name: "airplane"),
               SymbolModel(name: "command"),
               SymbolModel(name: "shift"),
               SymbolModel(name: "control"),
           ]
        let layout = createLayout()
        
        let frame = CGRect(x: self.view.frame.minX, y: 75, width: self.view.frame.width, height: self.view.frame.height - 75)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        
        let nib = UINib(nibName: "SymbolsCollectionViewCell", bundle: nil)
        
        collectionView.register(nib, forCellWithReuseIdentifier: "SymbolsCollectionViewCell")

        configureDataSource()
        
        self.view.addSubview(collectionView)
        collectionView.backgroundColor = .lightGray
        self.view.backgroundColor = .lightGray
        
        self.view.addSubview(searchBar)
    }

        lazy var searchBar : UISearchBar = {
        let s = UISearchBar()
            s.placeholder = "Search Timeline"
            s.delegate = self
            s.tintColor = .white
            s.barStyle = .default
            s.sizeToFit()
        return s
    }()
}

extension SearchableViewController {
    func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 150, height: 100)
        layout.scrollDirection = .vertical
        return layout
    }
    
    func configureDataSource() {
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
    }
    
    func performQuery(with filter: String?){
        let filteredSymbols: [SymbolModel]
        if let query = filter, !query.isEmpty {
            filteredSymbols = symbols.filter{ $0.contains(filter: query) }
        } else {
            filteredSymbols = symbols
        }

        var snapshot = NSDiffableDataSourceSnapshot<Section, SymbolModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(filteredSymbols, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
         performQuery(with: nil)
    }
}

extension SearchableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         performQuery(with: searchText)
    }
}

