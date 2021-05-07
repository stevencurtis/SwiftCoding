//
//  ViewController.swift
//  PinchInstagram
//
//  Created by Steven Curtis on 31/12/2020.
//

import UIKit

class ViewController: UIViewController {
    // This relates to the name of each image that will be displayed
    var data = ["1","2","3","4","5","6","7","8","1","2","3","4","5","6","7","8"]

    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // set the data source to be ViewController
        self.collectionView.dataSource = self
        // set the delegate to be the ViewController
        self.collectionView.delegate = self
        // register SubclassedCollectionViewCell
        self.collectionView.register(SubclassedCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
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
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 20, height: UIScreen.main.bounds.size.width / 1)
        // which scrolls vertically
        layout.scrollDirection = .vertical
        // setup the collectionview
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        // set the view as the collectionView
        self.view = collectionView
    }
}

extension ViewController: UICollectionViewDelegate {
    // out of the scope of this tutorial, we  print the index if that cell is selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
}

extension ViewController: UICollectionViewDataSource {
    // out of the scope of this tutorial, we will access the number of items in the data array
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return the number of images we wish to display
        data.count
    }
    
    // out of the scope of this tutorial, we dequeue the cell and setup the data in that cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SubclassedCollectionViewCell {
            // retrieve the correct piece of data
            let data = self.data[indexPath.item]
            // tell the cell to setup with the appropriate data
            cell.setupCell(image: data)
            // setup the delegate
            cell.delegate = self
            // setup the cell
            return cell
        }
        fatalError("Could not dequeue cell")
    }
}

extension ViewController: SubclassedCellDelegate {
    func zooming(started: Bool) {
        self.collectionView.isScrollEnabled = !started
    }
}
