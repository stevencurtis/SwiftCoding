//
//  ViewController.swift
//  VideoUICollectionView
//
//  Created by Steven Curtis on 02/01/2021.
//

import UIKit

class ViewController: UIViewController {
    var data = ["1","2","3","4","5","6","7","8","1","2","3","4","5","6","7","8"]

    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // set the data source to be ViewController
        self.collectionView.dataSource = self
        // set the delegate to be the ViewController
        self.collectionView.delegate = self
        // register SubclassedCollectionViewCell
        self.collectionView.register(
            SubclassedCollectionViewCell.self,
            forCellWithReuseIdentifier: "cell")
        // bouncing occurs when we reach the end of the UICollectionViewCells
        self.collectionView.alwaysBounceVertical = true
        // set the background of the collection view
        self.collectionView.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // call super of viewDidAppear
        super.viewDidAppear(animated)
    }

    override func loadView() {
        // set up a UICollectionViewFlowLayout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        // with a set item size
        layout.itemSize = CGSize(
            width: UIScreen.main.bounds.size.width - 20,
            height: UIScreen.main.bounds.size.width / 1)
        // which scrolls vertically
        layout.scrollDirection = .vertical
        // setup the collectionview
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout)
        // set the view as the collectionView
        self.view = collectionView
    }
        
    /// called when the user scrolls the scrollview (in this case a UICollectionView)
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // the visible cells are returned, and sorted into order
        let visibleCells = self.collectionView.indexPathsForVisibleItems
            .sorted { top, bottom -> Bool in
                return top.section < bottom.section || top.row < bottom.row
            }.compactMap { indexPath -> UICollectionViewCell? in
                return self.collectionView.cellForItem(at: indexPath)
            }
        // the indexpaths of the visible cells are sorted into order
        let indexPaths = self.collectionView.indexPathsForVisibleItems.sorted()
        // a property containing the number of visible cells
        let cellCount = visibleCells.count
        // if we don't have a first cell, we don't have any cells and there isn't anything to do
        guard let firstCell = visibleCells.first as? SubclassedCollectionViewCell, let firstIndex = indexPaths.first else {return}
        // check if the first cell is visible
        checkVisibilityOfCell(cell: firstCell, indexPath: firstIndex)
        if cellCount == 1 {return}
        // if we don't have a last cell, there is only one so we don't have more to do
        guard let lastCell = visibleCells.last as? SubclassedCollectionViewCell, let lastIndex = indexPaths.last else {return}
        // check if the last cell is visible
        checkVisibilityOfCell(cell: lastCell, indexPath: lastIndex)
    }
    /// check the visibility of the SubclassedCollectionViewCell
    func checkVisibilityOfCell(cell: SubclassedCollectionViewCell, indexPath: IndexPath) {
        // compute the frame of the cell
        if let cellRect = (collectionView.layoutAttributesForItem(at: indexPath)?.frame) {
            // it is visible iff the bounds of the cell are contained wholly in a collectionview
            let completelyVisible = collectionView.bounds.contains(cellRect)
            // update the cell accordingly
            if completelyVisible {cell.playVideo()} else {cell.stopVideo()}
        }
    }
}

extension ViewController: UICollectionViewDelegate {
    // out of the scope of this tutorial, we just print the index if that cell is selected
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
//    }
}

extension ViewController: UICollectionViewDataSource {
    // out of the scope of this tutorial, we will access the number of items in the data array
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    // out of the scope of this tutorial, we dequeue the cell and setup the data in that cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SubclassedCollectionViewCell {
            let data = self.data[indexPath.item]
            cell.setupCell(image: data)
            
            if let cellRect = (collectionView.layoutAttributesForItem(at: indexPath)?.frame) {
                let completelyVisible = collectionView.bounds.contains(cellRect)
                if completelyVisible {cell.playVideo()}
            }
            
            return cell
        }
        fatalError("Could not dequeue cell")
    }
}
