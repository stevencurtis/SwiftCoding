//
//  ViewController.swift
//  CollectionViewLayoutGuide
//
//  Created by Steven Curtis on 27/04/2021.
//

import UIKit

class BasicFlowLayoutViewController: UIViewController {
    enum Constants {
        static let reuseCell = "subclassedcell"
        static let reuseHeader = "header"
    }
    
    override func loadView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        self.view = collectionView
    }
    
    var collectionView: UICollectionView!
    let viewModel: BasicFlowLayoutViewModel
    
    init(viewModel: BasicFlowLayoutViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(SubclassedCollectionViewCell.self, forCellWithReuseIdentifier: Constants.reuseCell)
        self.collectionView?.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constants.reuseHeader)
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.backgroundColor = .white
    }
}

extension BasicFlowLayoutViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at CollectionView \(collectionView.tag) selected index path \(indexPath)")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.size.width, height: 123)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.reuseHeader, for: indexPath) as? HeaderView {
            headerView.title.text = "Section \(indexPath.section)"
            return headerView
        }
        fatalError("Could not dequeVuew")
    }
}

extension BasicFlowLayoutViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 100, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 2
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow)) - 20
        return CGSize(width: size, height: size)
    }
}

extension BasicFlowLayoutViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.sectionAdata.count
        }
        return viewModel.sectionBdata.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subclassedcell", for: indexPath) as? SubclassedCollectionViewCell {

            let data: UIColor
            if indexPath.section == 0 {
                data = viewModel.sectionAdata[indexPath.item]
            }
            else {
                data = viewModel.sectionBdata[indexPath.item]
            }
            cell.setupCell(colour: data)
            return cell
        }
        fatalError("Unable to dequeue subclassed cell")
    }
}
