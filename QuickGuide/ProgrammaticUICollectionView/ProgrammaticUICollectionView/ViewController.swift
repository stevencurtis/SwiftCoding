//
//  ViewController.swift
//  ProgrammaticUICollectionView
//
//  Created by Steven Curtis on 12/11/2020.
//

import UIKit

class ViewController: UIViewController {
    var data = [UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green, UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green, UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green, UIColor.red, UIColor.green, UIColor.blue, UIColor.green, UIColor.purple, UIColor.orange, UIColor.blue, UIColor.green, UIColor.blue, UIColor.green]
    
    // a property to hold the collectionView
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set the dataSource
        self.collectionView.dataSource = self
        // set the delegate
        self.collectionView.delegate = self
        // register the standard cell
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        // bounce at the bottom of the collection view
        self.collectionView.alwaysBounceVertical = true
        // set the background to be white
        self.collectionView.backgroundColor = .white
    }
    
    override func loadView() {
        // create a layout to be used
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        // make sure that there is a slightly larger gap at the top of each row
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        // set a standard item size of 60 * 60
        layout.itemSize = CGSize(width: 60, height: 60)
        // the layout scrolls horizontally
        layout.scrollDirection = .horizontal
        // set the frame and layout
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        // set the view to be this UICollectionView
        self.view = collectionView
    }
}

extension ViewController: UICollectionViewDelegate {
    // if the user clicks on a cell, display a message
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // the number of cells are wholly dependent on the number of colours
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // dequeue the standard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let data = self.data[indexPath.item]
        cell.backgroundColor = data
        return cell
    }
}
