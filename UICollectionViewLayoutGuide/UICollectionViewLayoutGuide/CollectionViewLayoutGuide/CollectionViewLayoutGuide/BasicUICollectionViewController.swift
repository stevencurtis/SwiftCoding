//
//  BasicUICollectionView.swift
//  CollectionViewLayoutGuide
//
//  Created by Steven Curtis on 27/04/2021.
//

import UIKit

class BasicUICollectionViewController: UIViewController {
    enum Constants {
        static let reuseCell = "subclassedcell"
    }
    
    var collectionView: UICollectionView!
    let viewModel: BasicUICollectionViewModel
    
    override func loadView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        self.view = collectionView
    }

    init(viewModel: BasicUICollectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(SubclassedCollectionViewCell.self, forCellWithReuseIdentifier: Constants.reuseCell)
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.backgroundColor = .white
    }
}

extension BasicUICollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at CollectionView \(collectionView.tag) selected index path \(indexPath)")
    }
}

extension BasicUICollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseCell, for: indexPath) as? SubclassedCollectionViewCell {
            let data = viewModel.data[indexPath.item]
            cell.setupCell(colour: data)
            return cell
        }
        fatalError("Unable to dequeue subclassed cell")
    }
}

